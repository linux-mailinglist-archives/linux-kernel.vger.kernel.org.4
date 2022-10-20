Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C160681D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJTSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTSWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7B1A6531;
        Thu, 20 Oct 2022 11:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD52B828D6;
        Thu, 20 Oct 2022 18:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCE1C433D6;
        Thu, 20 Oct 2022 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666290123;
        bh=HDx1VUXLXqIkvh18udXGeMs2VUJJstLVJ1RQIFEpJKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FRT+sCdYHIyTloHxtD18lczVYiMiNFLeACc2FQw2Kaln08o8TwSbZdBPmcEiqPs69
         ccgXIFgRrikv1NzWULE845avD3X9tO5N92B/w5C3JiQqRGk+DRA5/s0QHj+2Vn/Uq6
         N4SGOcQrnDL4vEuMYG2W6YYiD+vGgX0Tw8OEqn6I7uNj83yOMKVoY7NX4CXzdc3b6J
         Wb1ho2/PiRLDETFfiihmgGMEsBnNdxf3nty7ZaEXCD5vOG5c2gOockvyRER2kHmjqs
         aiOOVFbL/bovmVPstFcOzTCa1P3sB85SbUGpayG8G4/y+V8W/C+ftqjxcJCF4OWcsJ
         TxmyoIsC/9CZA==
Received: by mail-ej1-f54.google.com with SMTP id q9so1670951ejd.0;
        Thu, 20 Oct 2022 11:22:03 -0700 (PDT)
X-Gm-Message-State: ACrzQf2mnxD+cnvD+tWZg/9qNO9LKDtqgcusjONdZl8p2wpueKylOMFX
        wLWTPHkw5AbfI/hpmA79RRvHnkuszkiu8g4+lgs=
X-Google-Smtp-Source: AMsMyM6rBndJ2sgBfFKzB0PVAiHGjWqEgH88rEUQGLcZMoY3o+chkZoBl2FLhPOqx+8oO8uiFc9iLbB/OZZd6+Dw148=
X-Received: by 2002:a17:907:970b:b0:78d:8d70:e4e8 with SMTP id
 jg11-20020a170907970b00b0078d8d70e4e8mr11724579ejc.614.1666290122156; Thu, 20
 Oct 2022 11:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <Y0/Yt4uJWg4knNoc@infradead.org> <20221019160407.7550-1-giulio.benetti@benettiengineering.com>
 <Y1AhePTKiBS1WKf6@infradead.org>
In-Reply-To: <Y1AhePTKiBS1WKf6@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 20 Oct 2022 11:21:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7A+BGurCFY0b243uA8cRBgaVPCMMridJ5DBtUHxVOy5w@mail.gmail.com>
Message-ID: <CAPhsuW7A+BGurCFY0b243uA8cRBgaVPCMMridJ5DBtUHxVOy5w@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: drop RAID6_USE_EMPTY_ZERO_PAGE
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?RGlyayBNw7xsbGVy?= <dmueller@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 9:10 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 19, 2022 at 06:04:07PM +0200, Giulio Benetti wrote:
> > RAID6_USE_EMPTY_ZERO_PAGE is unused and hardcoded to 0, so let's drop it.
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to md-next. Thanks!

Song
