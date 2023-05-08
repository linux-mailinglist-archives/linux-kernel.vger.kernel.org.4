Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230186FB43F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjEHPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjEHPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:47:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801EA266;
        Mon,  8 May 2023 08:47:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 348Fl3jg054523;
        Mon, 8 May 2023 10:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683560823;
        bh=ThTMpPXBEPh4HdHzswHAKDf5fokfeMb5MpOdHcvdqgE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cAwMBQtt+9p61ybgcF82DbpMQgD20dsGzxfdQiMdlKtBtnVK2UXR045dEAVRh0lw2
         sTOwAqMYxGlLQJ385l3l0Bl8nRyL358LToNs2y2d5uPVKZa1Lk3e+hQ4572pQfyh7L
         0GnxlXQCzr1YRXEg2m0XQFvatQYp7I0Uu4DaPNUU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 348Fl3t3121784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 10:47:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 May 2023 10:47:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 May 2023 10:47:03 -0500
Received: from [10.250.149.252] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 348FkvEU003096;
        Mon, 8 May 2023 10:46:58 -0500
Message-ID: <a80f540a-492a-0585-9ed1-de3397535e07@ti.com>
Date:   Mon, 8 May 2023 21:16:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Build regressions/improvements in v6.4-rc1
Content-Language: en-US
To:     Pratyush Yadav <pratyush@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-um@lists.infradead.org>, <linux-media@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <sparclinux@vger.kernel.org>
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
 <20230508115727.2597864-1-geert@linux-m68k.org>
 <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <mafs035466ebk.fsf@amazon.de>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <mafs035466ebk.fsf@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/2023 8:49 PM, Pratyush Yadav wrote:
> On Mon, May 08 2023, Geert Uytterhoeven wrote:
> 
>> On Mon, 8 May 2023, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v6.4-rc1[1] compared to v6.3[2].
>>>
>>> Summarized:
>>>  - build errors: +9/-16
>>>  - build warnings: +1/-1439
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
>>>
>>>
> [...]
>>
>>>  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
> 
> Hmm, I don't get why we get this warning. Line 495 is in
> s25fs256t_post_bfpt_fixup(). It declares 'op' and then it does
> 
>     op = (struct spi_mem_op)
>         CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
>                       SPINOR_REG_CYPRESS_ARCFN, 1,
>                       nor->bouncebuf);
>     ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> 

Not all the fields of struct get initialized if you assign later on in
the function vs at the time of declaration... For example cmd.dtr isn't
explicitly set to any value here and may have garbage?
> 
> which initializes 'op' before using it. Same with line 364 which is in
> the function cypress_nor_set_addr_mode_nbytes().
> 
> Even the compiler warnings [0] don't seem to make much sense to me:
> 
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c: In function 's25fs256t_post_bfpt_fixup':
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: error: 'op' is used uninitialized [-Werror=uninitialized]
>     495 |         struct spi_mem_op op;
>         |                           ^~
>     /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: note: 'op' declared here
>     495 |         struct spi_mem_op op;
>         |                           ^~
> 
> [0] http://kisskb.ellerman.id.au/kisskb/buildresult/14922057/
> 
>>
>> um-x86_64-gcc12/um-allyesconfig
>>
> [...]
> 
