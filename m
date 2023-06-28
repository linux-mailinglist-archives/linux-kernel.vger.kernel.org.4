Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F787417FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjF1S0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF1S0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604691BE9;
        Wed, 28 Jun 2023 11:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA3926142A;
        Wed, 28 Jun 2023 18:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C82C433C0;
        Wed, 28 Jun 2023 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687976780;
        bh=5dS/hp0ttb4kLhVLrgEpv9hH1IBgDRlNs5EqvxHGAR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf2oa1nwOcm0vc7JNCj8SIS7lrTcwZ8lq/XEN9Kis6Wbd8261hsN26HYgBohT4bBp
         595fi07GoTc7w6Zyz1Fn/JCV9NrQt+S3EzjAsZllZJbpFAxc+jELRp1PRb8cu6d7cH
         7yePjmudRkPshnFauhGxbgtM0HiMNqYS3z+lJRhIqz0c4uyqyhC2tVtvq4h2glG8bI
         Ov3folZmHWZJ68nRLrzj4Q5i9CPqmkDpU6cKCTDNehumCf+R95dl9JUFjuHbFjhe+L
         5Zi6HRnsu7ya2B1LZcdVMPOcC1L/jRRq6GMrJYFrBt+gk2nODpkbwc9vLlBjyWc03E
         IoW5qUrTCCFyg==
Date:   Wed, 28 Jun 2023 11:26:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] media: verisilicon: fix excessive stack usage
Message-ID: <20230628182617.GA911656@dev-arch.thelio-3990X>
References: <20230616144854.3818934-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616144854.3818934-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 04:48:47PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some configurations, gcc decides not to inline the register accessor functions,
> which in turn leads to lots of temporary hantro_reg structures on the stack that
> cannot be eliminated because they escape into an uninlined function:
> 
> drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:1022:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Mark all of these as __always_inline so the compiler is able to completely
> eliminate the temporary structures instead, which brings the stack usage
> back down to just the normal local variables.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306151506.goHEegOd-lkp@intel.com/
> Fixes: 727a400686a2c ("media: verisilicon: Add Rockchip AV1 decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For what it's worth, this patch massively helps with avoiding a warning
with clang 16.x and older, for presumably a similar reason, since this
happens with allmodconfig, which turns on a bunch of sanitizers.

https://github.com/ClangBuiltLinux/linux/issues/1875

Before this change:

  drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:2097:5: error: stack frame size (2096) exceeds limit (2048) in 'rockchip_vpu981_av1_dec_run' [-Werror,-Wframe-larger-than]
  int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
      ^
  238/2096 (11.35%) spills, 1858/2096 (88.65%) variables

After this change:

  drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c:2097:5: error: stack frame size (496) exceeds limit (200) in 'rockchip_vpu981_av1_dec_run' [-Werror,-Wframe-larger-than]
  int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
      ^
  265/496 (53.43%) spills, 231/496 (46.57%) variables

If this could be picked up either before the 6.5 media pull goes out or
at some point during the -rc cycle, that would be great!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/media/platform/verisilicon/hantro.h | 22 ++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 6523ffb748812..6c5e56ce5b351 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -370,26 +370,26 @@ extern int hantro_debug;
>  	pr_err("%s:%d: " fmt, __func__, __LINE__, ##args)
>  
>  /* Structure access helpers. */
> -static inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
> +static __always_inline struct hantro_ctx *fh_to_ctx(struct v4l2_fh *fh)
>  {
>  	return container_of(fh, struct hantro_ctx, fh);
>  }
>  
>  /* Register accessors. */
> -static inline void vepu_write_relaxed(struct hantro_dev *vpu,
> +static __always_inline void vepu_write_relaxed(struct hantro_dev *vpu,
>  				      u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
>  	writel_relaxed(val, vpu->enc_base + reg);
>  }
>  
> -static inline void vepu_write(struct hantro_dev *vpu, u32 val, u32 reg)
> +static __always_inline void vepu_write(struct hantro_dev *vpu, u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
>  	writel(val, vpu->enc_base + reg);
>  }
>  
> -static inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
> +static __always_inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
>  {
>  	u32 val = readl(vpu->enc_base + reg);
>  
> @@ -397,27 +397,27 @@ static inline u32 vepu_read(struct hantro_dev *vpu, u32 reg)
>  	return val;
>  }
>  
> -static inline void vdpu_write_relaxed(struct hantro_dev *vpu,
> +static __always_inline void vdpu_write_relaxed(struct hantro_dev *vpu,
>  				      u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
>  	writel_relaxed(val, vpu->dec_base + reg);
>  }
>  
> -static inline void vdpu_write(struct hantro_dev *vpu, u32 val, u32 reg)
> +static __always_inline void vdpu_write(struct hantro_dev *vpu, u32 val, u32 reg)
>  {
>  	vpu_debug(6, "0x%04x = 0x%08x\n", reg / 4, val);
>  	writel(val, vpu->dec_base + reg);
>  }
>  
> -static inline void hantro_write_addr(struct hantro_dev *vpu,
> +static __always_inline void hantro_write_addr(struct hantro_dev *vpu,
>  				     unsigned long offset,
>  				     dma_addr_t addr)
>  {
>  	vdpu_write(vpu, addr & 0xffffffff, offset);
>  }
>  
> -static inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
> +static __always_inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
>  {
>  	u32 val = readl(vpu->dec_base + reg);
>  
> @@ -425,7 +425,7 @@ static inline u32 vdpu_read(struct hantro_dev *vpu, u32 reg)
>  	return val;
>  }
>  
> -static inline u32 vdpu_read_mask(struct hantro_dev *vpu,
> +static __always_inline u32 vdpu_read_mask(struct hantro_dev *vpu,
>  				 const struct hantro_reg *reg,
>  				 u32 val)
>  {
> @@ -437,14 +437,14 @@ static inline u32 vdpu_read_mask(struct hantro_dev *vpu,
>  	return v;
>  }
>  
> -static inline void hantro_reg_write(struct hantro_dev *vpu,
> +static __always_inline void hantro_reg_write(struct hantro_dev *vpu,
>  				    const struct hantro_reg *reg,
>  				    u32 val)
>  {
>  	vdpu_write_relaxed(vpu, vdpu_read_mask(vpu, reg, val), reg->base);
>  }
>  
> -static inline void hantro_reg_write_s(struct hantro_dev *vpu,
> +static __always_inline void hantro_reg_write_s(struct hantro_dev *vpu,
>  				      const struct hantro_reg *reg,
>  				      u32 val)
>  {
> -- 
> 2.39.2
> 
