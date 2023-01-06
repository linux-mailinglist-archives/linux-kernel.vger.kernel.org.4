Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE18660739
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjAFTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjAFTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:34:44 -0500
X-Greylist: delayed 1140 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 11:34:41 PST
Received: from 19.mo550.mail-out.ovh.net (19.mo550.mail-out.ovh.net [178.32.97.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C3C76813
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:34:41 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.4.132])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id C466C23D85
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 19:15:39 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-2mh8d (unknown [10.110.208.218])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 997A81FEE4;
        Fri,  6 Jan 2023 19:15:39 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-2mh8d with ESMTPSA
        id ELr3I1tzuGO5GwAAZ2D+lg
        (envelope-from <rafal@milecki.pl>); Fri, 06 Jan 2023 19:15:39 +0000
MIME-Version: 1.0
Date:   Fri, 06 Jan 2023 20:15:39 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
In-Reply-To: <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
References: <20221012155133.287-1-musashino.open@gmail.com>
 <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e8932e3eaf1bd9a690e2f41aad8faf3a@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8312237537736436699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefhvefhgfffheegveeujeduveekvdevkeefvddvfeduuddvgfdukeeugeffvdduffenucffohhmrghinhepghhithdrnhhofienucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpddujeeirdefuddrvdefhedrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 2022-11-11 18:41, Srinivas Kandagatla wrote:
> On 12/10/2022 16:51, INAGAKI Hiroshi wrote:
>> This patch fixes crc32 error on Big-Endianness system by conversion of
>> calculated crc32 value.
>> 
>> Little-Endianness system:
>> 
>>    obtained crc32: Little
>> calculated crc32: Little
>> 
>> Big-Endianness system:
>> 
>>    obtained crc32: Little
>> calculated crc32: Big
>> 
>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>> 
>> [    8.570000] u_boot_env 
>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated 
>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>> [    8.580000] u_boot_env: probe of 
>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>> 
>> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment 
>> variables")
>> 
>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>> ---
> 
> Applied thanks,

has this patch been lost somewhere in the process?

I'm quite sure I saw it in linux-next.git and probably in nvmem.git. Now
it seems to be gone.
