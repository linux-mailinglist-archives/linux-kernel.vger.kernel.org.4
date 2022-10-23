Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136A6091B9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJWHwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJWHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:52:31 -0400
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26B73925;
        Sun, 23 Oct 2022 00:52:28 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id BD069135D; Sun, 23 Oct 2022 09:52:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id BA59212E7;
        Sun, 23 Oct 2022 09:52:20 +0200 (CEST)
Date:   Sun, 23 Oct 2022 09:52:20 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: encrypted: fix key instantiation with user-provided
 data
In-Reply-To: <Y1TPPOuF4qm4eHTx@kernel.org>
Message-ID: <c0562c3-aa31-098-4473-ac8818fdc5a@vosn.de>
References: <20221013064308.857011E25@mail.steuer-voss.de> <Y1TOv6F8KNXvNx9l@kernel.org> <Y1TPPOuF4qm4eHTx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022, Jarkko Sakkinen wrote:
> On Sun, Oct 23, 2022 at 08:18:58AM +0300, Jarkko Sakkinen wrote:
>> On Thu, Oct 13, 2022 at 08:39:58AM +0200, Nikolaus Voss wrote:
>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
>>> decrypted data") added key instantiation with user provided decrypted data.
>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
>>> Fix this to use hex2bin instead.
>>>
>>> Old keys created from user provided decrypted data saved with "keyctl pipe"
>>> are still valid, however if the key is recreated from decrypted data the
>>> old key must be converted to the correct format. This can be done with a
>>> small shell script, e.g.:
>>>
>>> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
>>> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
>>> keyctl add user masterkey "$(cat masterkey.bin)" @u
>>> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
>>>
>>> It is encouraged to switch to a new key because the effective key size
>>> of the old keys is only half of the specified size.
>>>
>>> The corresponding test for the Linux Test Project ltp has also been
>>> fixed (see link below).
>>>
>>> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
>>> Cc: stable <stable@kernel.org>
>>> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
>>> ---
>>> Changes
>>> =======
>>> v4: - fixed link
>>> v3: - use generated random key in example, reformat commit message
>>> v2: - clarify commit message, add example to recover old/broken keys
>>>     - improve example in Documentation/security/keys/trusted-encrypted.rst
>>>     - add link to ltp patch
>>>
>>>  Documentation/security/keys/trusted-encrypted.rst | 3 ++-
>>>  security/keys/encrypted-keys/encrypted.c          | 6 +++---
>>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>>> index 0bfb4c339748..9bc9db8ec651 100644
>>> --- a/Documentation/security/keys/trusted-encrypted.rst
>>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>>> @@ -350,7 +350,8 @@ Load an encrypted key "evm" from saved blob::
>>>
>>>  Instantiate an encrypted key "evm" using user-provided decrypted data::
>>>
>>> -    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
>>> +    $ evmkey=$(dd if=/dev/urandom bs=1 count=32 | xxd -c32 -p)
>>> +    $ keyctl add encrypted evm "new default user:kmk 32 $evmkey" @u
>>>      794890253
>>>
>>>      $ keyctl print 794890253
>>> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
>>> index e05cfc2e49ae..1e313982af02 100644
>>> --- a/security/keys/encrypted-keys/encrypted.c
>>> +++ b/security/keys/encrypted-keys/encrypted.c
>>> @@ -627,7 +627,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>>  			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
>>>  			return ERR_PTR(-EINVAL);
>>>  		}
>>> -		if (strlen(decrypted_data) != decrypted_datalen) {
>>> +		if (strlen(decrypted_data) != decrypted_datalen * 2) {
>>>  			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
>>>  			return ERR_PTR(-EINVAL);
>>>  		}
>>> @@ -791,8 +791,8 @@ static int encrypted_init(struct encrypted_key_payload *epayload,
>>>  		ret = encrypted_key_decrypt(epayload, format, hex_encoded_iv);
>>>  	} else if (decrypted_data) {
>>>  		get_random_bytes(epayload->iv, ivsize);
>>> -		memcpy(epayload->decrypted_data, decrypted_data,
>>> -				   epayload->decrypted_datalen);
>>> +		ret = hex2bin(epayload->decrypted_data, decrypted_data,
>>> +			      epayload->decrypted_datalen);
>>>  	} else {
>>>  		get_random_bytes(epayload->iv, ivsize);
>>>  		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
>>> --
>>> 2.34.1
>>>
>>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Unless there is opposing views, I can pick this.
>
> Actually, taking this back: please fix the checkpatch warnings first.

I fixed the warnings in v5, Mimi took this already.

Niko
