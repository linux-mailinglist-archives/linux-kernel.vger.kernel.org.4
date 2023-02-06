Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA068C044
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBFOh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBFOh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:37:56 -0500
X-Greylist: delayed 7857 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 06:37:54 PST
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33A283EC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:37:53 -0800 (PST)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.143.136])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 296BF25C48
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:09:49 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5xm75 (unknown [10.109.138.60])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7378A1FD29;
        Mon,  6 Feb 2023 12:09:48 +0000 (UTC)
Received: from RCM-web8.webmail.mail.ovh.net ([151.80.29.22])
        by ghost-submission-6684bf9d7b-5xm75 with ESMTPSA
        id D943Ggzu4GNHfgAA+nEPng
        (envelope-from <rafal@milecki.pl>); Mon, 06 Feb 2023 12:09:48 +0000
MIME-Version: 1.0
Date:   Mon, 06 Feb 2023 13:09:48 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [RESEND PATCH 30/37] nvmem: core: fix
 nvmem_layout_get_match_data()
In-Reply-To: <Y+Dst2V9mfJbVrzD@kroah.com>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
 <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
 <Y+Dst2V9mfJbVrzD@kroah.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c6394c5daead464df1ddad781829668e@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17153366559586757602
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpefghfeuiefhiedttedtheefhfeifeffveekvdegteetkeetjedtiedvvdfhgfffffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdduleegrddukeejrdejgedrvdeffedpudehuddrkedtrddvledrvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorhgrfhgrlhesmhhilhgvtghkihdrphhlqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 13:04, Greg KH wrote:
> On Mon, Feb 06, 2023 at 10:27:52AM +0000, Srinivas Kandagatla wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> This function was trying to match wrong OF node (parent device's)
>> against an of_match_table. It was always returning NULL.
>> 
>> Make it match layout's OF node against layout's of_match_table.
>> 
>> Note: __maybe_unused is needed to avoid:
>> warning: variable 'layout_np' set but not used 
>> [-Wunused-but-set-variable]
>> (of_match_node() is no-op without CONFIG_OF).
>> 
>> Fixes: 61a093b4a0e0 ("nvmem: core: introduce NVMEM layouts")
> 
> Nit, how can you have a git commit id if you are sending me patches to
> be applied to my tree?
> 
> That's never going to work, sorry.

That was commit I found in the:
https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git/log/?h=for-next

With Srinivas sending patches and not merge request, it doesn't make
sense obviously.

Srinivas could you rebase your branch making my patch a fixup for the
commit 61a093b4a0e0?
