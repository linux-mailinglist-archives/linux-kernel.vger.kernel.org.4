Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026446207DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiKHD4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKHD42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:56:28 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC131264A1;
        Mon,  7 Nov 2022 19:56:27 -0800 (PST)
Received: from [192.168.43.35] (42-72-159-215.emome-ip.hinet.net [42.72.159.215])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 75C36422BF;
        Tue,  8 Nov 2022 03:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667879785;
        bh=0lAmA2xZiuustTD5Iab19OKJCMRHWwA7na99usxYrVE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JWm2j9VQOM6i+yoby3P9rQcPwjGqokH3TQTGxhy+Or6yXtxlYu6LHRRiIN0cSVu8j
         N6PquUbxeazlilTKSx3DWvjuhjufR7xqCFHu8Wa/ODifE8V6H0eEj8Xv9vrRfBrK5T
         uurHs/btVuXXdGDtGrXCoB0G0X7J8TnC015VnK0tNqPVpIkf1KoFB1aazHVe33FIEd
         SucMLJOdeyHRWfkuPbnwnN+vWrtQgrCmR9K58bLCGJdgiR90zzDzV3hSeAvUx9nfU9
         /a48AtAbmqVCNwsQY4tp86JWFMdm+eQMnAgl4NGEpdKkVXCkLLQvc0BELGp+Lzjels
         gHuSrB2AIRFjA==
Message-ID: <0b298830-47cc-bb94-0e73-493e4e9244f7@canonical.com>
Date:   Tue, 8 Nov 2022 11:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/7] Add camera access keys, IdeaPad driver
 improvements
Content-Language: en-US
To:     =?UTF-8?Q?Eray_Or=c3=a7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com, pobrn@protonmail.com
References: <20221029120311.11152-1-erayorcunus@gmail.com>
From:   Ike Panhc <ike.pan@canonical.com>
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 20:03, Eray Orçunus wrote:
> Nowadays many laptops have camera access keys, yet there is no usage codes
> mapped to them, even though it's introduced in HUTRR72. Start point of
> this patch series was adding it and making IdeaPads send it to userspace.
> But later I discovered that camera_power attribute of ideapad-laptop
> driver on my IdeaPad 520-15IKB doesn't work, so I can't toggle it with
> that. I managed to find a way to check whether an IdeaPad supports
> camera_power attribute (which sends VPCCMD_W_CAMERA to EC), don't expose
> it to sysfs so userspace will know that it can't toggle camera access via
> camera_power, in my case, after receiving KEY_CAMERA_ACCESS_TOGGLE.
> 
> Along the way I discovered that old IdeaPads, like S10-3, may not be able
> to toggle their touchpad as a regression of a commit aimed for newer
> IdeaPads, so I reverted it.
> 
> Also I noticed that I can get/set the state of my keyboard light,
> so one of the patches also adds supports for this kind of keyboard lights,
> which I call "partially supported keyboard lights". I expect that commit
> to add keyboard light support for 520-15IKB, 330-17ICH, 5 (15) and more.
> Currently only tested on 520-15IKB.

Thanks. Also test on my ideapad s410 and it looks good.

Acked-by: Ike Panhc <ike.pan@canonical.com>


