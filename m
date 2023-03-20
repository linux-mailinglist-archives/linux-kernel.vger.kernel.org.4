Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F216C145E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCTOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:08:40 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 07:08:38 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3A21986;
        Mon, 20 Mar 2023 07:08:38 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7F5A42C92EE;
        Mon, 20 Mar 2023 14:00:56 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CA008500091;
        Mon, 20 Mar 2023 14:00:52 +0000 (UTC)
Received: from [172.18.0.100] (unknown [67.201.77.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EE74E13C2B5;
        Mon, 20 Mar 2023 07:00:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EE74E13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1679320851;
        bh=u5lmYgOOhXsqx3puKJdpQFWNJ5KhHgjqYqDOTf2rFaI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=G4y4Y+BwZNMqggHpPt8KjASqGHeBaT06J9iRD58A2kWY8zAFrcQ/IMvfG2fqw0cEZ
         3M5WCEycI2Rnv56ubcTx+oARSdP9P+6XqwQF4tkNSvZWQ3S5UJT7xtK8vf3PX8tPLD
         X2JJdtiulM6T6AK2xoJ1nz289G2cOKX9bomdHq3o=
Message-ID: <121d75eb-da8e-e120-3754-391a0c064001@candelatech.com>
Date:   Mon, 20 Mar 2023 07:00:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: BUG: KASAN: vmalloc-out-of-bounds in
 mt7921_check_offload_capability+0x3fa/0x430 [mt7921_common]
Content-Language: en-MW
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        Felix Fietkau <nbd@nbd.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsMOZ7LQgem+vpjytU5MybGrOmRH_hnkckQCx8_wCknecA@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CABXGCsMOZ7LQgem+vpjytU5MybGrOmRH_hnkckQCx8_wCknecA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1679320854-e7aJgIBbGY-r
X-MDID-O: us5;ut7;1679320854;e7aJgIBbGY-r;<greearb@candelatech.com>;0bc9fb74e1a2ec8b702523a369db6eec
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 03:32, Mikhail Gavrilov wrote:
> Hi,
> After enabling KASAN sanitizer the message "BUG: KASAN:
> vmalloc-out-of-bounds in mt7921_check_offload_capability+0x3fa/0x430
> [mt7921_common]" chase me at every boot.

This is use-after-free bug, and I already posted a patch to fix it.
"wireless: mt76: mt7921: Fix use-after-free in fw features query."

Thanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
