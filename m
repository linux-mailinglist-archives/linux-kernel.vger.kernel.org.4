Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1A73001E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjFNNdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjFNNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:33:01 -0400
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315771BFD;
        Wed, 14 Jun 2023 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1686749581; x=1718285581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=KsVXSUgWvEyxPZ6XcTppAUfu9AfW7QxpE0gPbP31rmI=;
  b=gzBzzEgm4ObxT6Xd9TVUmF0LV4OEwORmvs77zVpdEqs2bePUbGiz5GYA
   uhEgOsfkUU6xWYi8ADg+nbu3kRuhmhXzmJ7PvwuyvyNFBEeE224RJYvlG
   V2N4P+VnleGCZ1+6u2mfcWJBeQAyWpt55ML9IDshF4zgwDEfjh7g/kE5t
   I=;
X-IronPort-AV: E=Sophos;i="6.00,242,1681171200"; 
   d="scan'208";a="654141436"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:32:56 +0000
Received: from EX19D007EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 40F9D80451;
        Wed, 14 Jun 2023 13:32:54 +0000 (UTC)
Received: from EX19D039EUC001.ant.amazon.com (10.252.61.245) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 13:32:51 +0000
Received: from EX19D039EUC004.ant.amazon.com (10.252.61.190) by
 EX19D039EUC001.ant.amazon.com (10.252.61.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 13:32:51 +0000
Received: from EX19D039EUC004.ant.amazon.com ([fe80::5319:6fc9:8bde:8a4]) by
 EX19D039EUC004.ant.amazon.com ([fe80::5319:6fc9:8bde:8a4%3]) with mapi id
 15.02.1118.026; Wed, 14 Jun 2023 13:32:51 +0000
From:   "Adam, Mahmoud" <mngyadam@amazon.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Mahmoud Adam <mngyadam@amazon.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: use kfree_sensitive with key
Thread-Topic: [PATCH] KEYS: use kfree_sensitive with key
Thread-Index: AQHZnhE6QjFYrnWk7EKzcHc3QmFVcK+KDvmAgAA+R4A=
Date:   Wed, 14 Jun 2023 13:32:51 +0000
Message-ID: <CB10C1D8-BA86-4E1B-B9B7-FDF6AFD3E089@amazon.de>
References: <20230613160723.61729-1-mngyadam@amazon.com>
 <ZImNO0AijmNriZuL@gondor.apana.org.au>
In-Reply-To: <ZImNO0AijmNriZuL@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.8]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B0F688BB9AD664094D6610EA5B23B0D@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14. Jun 2023, at 11:49, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> =

> On Tue, Jun 13, 2023 at 04:07:23PM +0000, Mahmoud Adam wrote:
>> key member might contain private part of the key, so better use
>> kfree_sensitive to free it
>> =

>> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
>> ---
>> crypto/asymmetric_keys/public_key.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
>> =

>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_key=
s/public_key.c
>> index eca5671ad3f2..006ae170a16f 100644
>> --- a/crypto/asymmetric_keys/public_key.c
>> +++ b/crypto/asymmetric_keys/public_key.c
>> @@ -43,7 +43,7 @@ static void public_key_describe(const struct key *asym=
metric_key,
>> void public_key_free(struct public_key *key)
>> {
>> if (key) {
>> - kfree(key->key);
>> + kfree_sensitive(key->key);
> =

> The public key should not be freed with kfree_sensitive.

I think this holds for the other lines as well, I can use pkey->key_is_priv=
ate to check for them also

Thanks.




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



