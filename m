Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58B6FB3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjEHPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29563A2;
        Mon,  8 May 2023 08:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26AD62E17;
        Mon,  8 May 2023 15:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54179C433EF;
        Mon,  8 May 2023 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683559172;
        bh=TFzPKqH85O0PJiVNWjP4+BZQJgCJpfZyNmq88Kq2LS4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SsqGI4Udvoy7Xur23L/a4pdzWsb+wimg+nsLzCqFRO+S+esnFYAo2T+jCUXodRptl
         3Uqu/fiUNrxCV6eHnOjh1gLGuUkNSPJcIxtSCx80rdh3EPEx+hFRg9xo74b7WkzSR2
         OreQ0SS5g2jz0zcorBIITdYtb7UNfAYExtzAjqjlQbx4xOth+F1vF2CRWfxklwKb6N
         JHj8rkBEqvrUwG3al29CWo1V7Tv/9RoEL17XiuQtvdWSgEU3kFpkpICKLlNPDCmj26
         X16rlSR2RuSyE5WEiSwYVNBdg3wFbr2/e1wbPbTL1HgCJpAPoNhnSleBG7yh37b7rX
         efwqtRaOS+XNA==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-um@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4-rc1
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
        <20230508115727.2597864-1-geert@linux-m68k.org>
        <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
Date:   Mon, 08 May 2023 17:19:27 +0200
In-Reply-To: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org> (Geert
        Uytterhoeven's message of "Mon, 8 May 2023 14:14:32 +0200 (CEST)")
Message-ID: <mafs035466ebk.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08 2023, Geert Uytterhoeven wrote:

> On Mon, 8 May 2023, Geert Uytterhoeven wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v6.4-rc1[1] compared to v6.3[2].
>>
>> Summarized:
>>  - build errors: +9/-16
>>  - build warnings: +1/-1439
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ac9a78681b921877518763ba0e89202254349d1b/ (all 152 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/457391b0380335d5e9a5babdec90ac53928b23b4/ (all 152 configs)
>>
>>
[...]
>
>>  + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27

Hmm, I don't get why we get this warning. Line 495 is in
s25fs256t_post_bfpt_fixup(). It declares 'op' and then it does

    op = (struct spi_mem_op)
        CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
                      SPINOR_REG_CYPRESS_ARCFN, 1,
                      nor->bouncebuf);
    ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);


which initializes 'op' before using it. Same with line 364 which is in
the function cypress_nor_set_addr_mode_nbytes().

Even the compiler warnings [0] don't seem to make much sense to me:

    /kisskb/src/drivers/mtd/spi-nor/spansion.c: In function 's25fs256t_post_bfpt_fixup':
    /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: error: 'op' is used uninitialized [-Werror=uninitialized]
    495 |         struct spi_mem_op op;
        |                           ^~
    /kisskb/src/drivers/mtd/spi-nor/spansion.c:495:27: note: 'op' declared here
    495 |         struct spi_mem_op op;
        |                           ^~

[0] http://kisskb.ellerman.id.au/kisskb/buildresult/14922057/

>
> um-x86_64-gcc12/um-allyesconfig
>
[...]

-- 
Regards,
Pratyush Yadav
