Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA16B0E77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCHQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:20:25 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF4B6926;
        Wed,  8 Mar 2023 08:20:23 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328GKEPW078456;
        Wed, 8 Mar 2023 10:20:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678292414;
        bh=ZZWvuPuHCAyPcR/LCGAMM4pzjn50c6d9ZHF4PKiN8mw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LUCnQ8IkHlfSwFEr4X7eJSxZB61mja61EE7pRMM+YuA/IL9Ydk7TmDOVj1e/ptvwU
         g5/QsAv2C/LxQRgxeX2g9KCbrtZPNwOe3WbU4Ke/TDfwZInRI8tabbJaGZAz2bfbHY
         DKtIPI+0MWMM4KqKk7fq4HxPOiaQq77/V7MK56u0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328GKEev118313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 10:20:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 10:20:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 10:20:14 -0600
Received: from [128.247.81.39] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328GKDIS046027;
        Wed, 8 Mar 2023 10:20:14 -0600
Message-ID: <f7561edb-be14-d78e-0f97-54ef6bd4eaea@ti.com>
Date:   Wed, 8 Mar 2023 10:20:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-3-afd@ti.com>
 <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
 <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com>
 <9c705260-c04c-da2e-db9a-df3ddfb69efc@ti.com>
 <CAHp75Vf9oMUmr473PSjcbXjEA+BFNpSPrLd22X=B378qNasrqA@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAHp75Vf9oMUmr473PSjcbXjEA+BFNpSPrLd22X=B378qNasrqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 9:53 AM, Andy Shevchenko wrote:
> On Wed, Mar 8, 2023 at 5:50 PM Andrew Davis <afd@ti.com> wrote:
>> On 3/8/23 4:32 AM, Bartosz Golaszewski wrote:
>>> On Wed, Mar 8, 2023 at 11:24 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> ...
> 
>>> I see there's v2 out, backing it out then.
>>
>> Looks like I missed something that kernel test robot found, so there
>> will be a v3.
> 
> Just split your series on a per driver basis. This will help with
> understanding what's going on. Also use a cover letter to explain what
> your series is for.
> 

There is one patch per driver, not sure what you mean by split per driver?

Will add a cover letter for v3 and drop the first patch that's in your tree already.

Andrew
