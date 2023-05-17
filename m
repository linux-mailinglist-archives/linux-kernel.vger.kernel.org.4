Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8970706E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjEQSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEQSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BACB0;
        Wed, 17 May 2023 11:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB23649E3;
        Wed, 17 May 2023 18:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59121C433EF;
        Wed, 17 May 2023 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684346876;
        bh=fFAQZam9M9GaiJNW3WGAqDih6/zmyl0kx8ysWpMj0WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/QWdDVAs6ecpvp4JtgSMAgngJmiD4LVWf5EX+ggp09aHS5JhVJO5AZTR2rqwtvuD
         PrZnBWsZTppJ8mC2sjtxPM0KR3WVmVR5DVqEahaByES2GmBUmfAT9tEVgE+xeICORj
         VL+Z7nx1GkhOtWfwiiSwspOq92zj3kkvziWfsvcW1ltbfJLXd4fTXbJkCufDva4lW1
         sbblEy8ZZ9oTGSRzNmGfoPZp98C3AV27Qraaaru72/6gwJvTS4b9yNc1UeCoI+DXKH
         2BOBwCiDhQgxmjrpCDIbLp6SCC3CinzTinq64wh7Qktj1ggE55sEIeUEDX+pcQHNpE
         G1DybcnsONI0w==
Date:   Wed, 17 May 2023 12:08:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array
 with flexible-array member
Message-ID: <ZGUYLoqwrcVsjiaH@work>
References: <ZGQn63U4IeRUiJWb@work>
 <202305171049.9AB52166@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305171049.9AB52166@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:50:53AM -0700, Kees Cook wrote:
> On Tue, May 16, 2023 at 07:03:39PM -0600, Gustavo A. R. Silva wrote:
> > One-element arrays are deprecated, and we are replacing them with flexible
> > array members instead. So, replace one-element arrays with flexible-array
> > members in struct hfi_sys_set_resource_pkt, and refactor the rest of
> > the code, accordingly.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > The only binary differences seen before/after changes are the
> > following:
> > 
> >      17ba:      mov    %rbx,%rdi
> >      17bd:      call   17c2 <pkt_sys_set_resource+0x42>
> >                         17be: R_X86_64_PLT32    __tsan_write4-0x4
> > -    17c2:      movl   $0x14,(%rbx)
> > +    17c2:      movl   $0x10,(%rbx)
> >      17c8:      lea    0x4(%rbx),%rdi
> >      17cc:      call   17d1 <pkt_sys_set_resource+0x51>
> >                         17cd: R_X86_64_PLT32    __tsan_write4-0x4
> > 
> > which is expected once this accounts for the following line of code
> > at  drivers/media/platform/qcom/venus/hfi_cmds.c:73
> > 
> > 73         pkt->hdr.size = sizeof(*pkt);
> > 
> > and as *pkt is of type struct hfi_sys_set_resource_pkt, sizeof(*pkt) is
> > reduced by 4 bytes, due to the flex-array transformation.
> 
> Based on the other place that was subtracting the 1 element, this looks

Do you mean the one you commented on yesterday?

https://lore.kernel.org/linux-hardening/ZGPk3PpvYzjD1+0%2F@work/ this?

--
Gustavo

> like hfi_cmds.c:73 is an existing sizing bug that is now fixed with this
> patch, yes?
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/293
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
> >  drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> > index 3f74d518ad08..7c82e212434e 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> > +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> > @@ -83,7 +83,7 @@ int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
> >  		res->size = size;
> >  		res->mem = addr;
> >  		pkt->resource_type = HFI_RESOURCE_OCMEM;
> > -		pkt->hdr.size += sizeof(*res) - sizeof(u32);
> > +		pkt->hdr.size += sizeof(*res);
> >  		break;
> >  	}
> >  	case VIDC_RESOURCE_NONE:
> > diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> > index ba74d03eb9cd..dd9c5066442d 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> > @@ -56,7 +56,7 @@ struct hfi_sys_set_resource_pkt {
> >  	struct hfi_pkt_hdr hdr;
> >  	u32 resource_handle;
> >  	u32 resource_type;
> > -	u32 resource_data[1];
> > +	u32 resource_data[];
> >  };
> >  
> >  struct hfi_sys_release_resource_pkt {
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Kees Cook
