Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047516DB1AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDGRfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDGRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3975B74C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680888900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VgSBn4v63sH/hPEOpjuOfluIneyO592ey/flc3R1Lws=;
        b=ZVOQpywM/ihvbcFJMqZ6oqfoZgQPs3K/v1FXm38XDIf83KE8JgM5jwYEFDyItUh46nvCCM
        B2FJqY3os5gp1Q82tT6puKwEn7Z9dGqu7sXQXYI++sPIJMfsRMmK1VoFdwfNIMolyIg2dV
        6letRGpm0babh+lpx9neiBqmklf+/SY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-1DaUEofAOhiunlruhUHXiw-1; Fri, 07 Apr 2023 13:34:58 -0400
X-MC-Unique: 1DaUEofAOhiunlruhUHXiw-1
Received: by mail-oo1-f71.google.com with SMTP id k3-20020a4a9483000000b00541aa021802so376086ooi.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680888897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgSBn4v63sH/hPEOpjuOfluIneyO592ey/flc3R1Lws=;
        b=TVb2Xrm9xYxImMLJ8U9qr8BmE/VADI/yE/XgmXZ5xbnvudEbSZUB3DvFmWFNTsJ6dv
         p3aI0jqxyz2ODeP7HnkiXzrvF8o8aQVXGsB6Ay42rtiLo9fLCniT6sgZpL8Poyo+4g3j
         ouvireYMOkt2UR4b7/IaWgfby1kuyLxJgwnSLR5LrUuoc25SbPVB7H6WQISYzG6UBoI7
         Od68KPTdj47o5EKT58BLvkPhSBzfNOzTt8LBACauNC8cgpqMl6809d3V8t4gCo/hNqTp
         EPTLD9+43nCzzCTnJzUjuv26rc05UKOtVsfjlw/ErQwcvqk4mmyYayowa5OPx7L5S5Ao
         5iow==
X-Gm-Message-State: AAQBX9dPwL3ZqjsjXGHyaoKXtfGVTwRRBKkMytNXQ+WBXYGi/v3oGf8L
        Jn7riba9KyE+0DTxejJvXZWoApGfL62FPT7IkUdoG9dtx8hUawr/56kDdZq390PaXw1dXGlG7Tk
        Whw+KVKNpwkS3FiN9rZcbx558hDqzHHcHc8g=
X-Received: by 2002:a05:6871:828:b0:17a:ce6b:726 with SMTP id q40-20020a056871082800b0017ace6b0726mr1927750oap.57.1680888897164;
        Fri, 07 Apr 2023 10:34:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350YXsTSTagUzg6KkiTKxiPA0gPNgmGx86bP9YtG1X657Q3uhpK3CFF1WVzwPqGtc/1IMJf5fWg==
X-Received: by 2002:a05:6871:828:b0:17a:ce6b:726 with SMTP id q40-20020a056871082800b0017ace6b0726mr1927741oap.57.1680888896927;
        Fri, 07 Apr 2023 10:34:56 -0700 (PDT)
Received: from halaney-x13s (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id y1-20020a056870458100b001777244e3f9sm1822096oao.8.2023.04.07.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:34:56 -0700 (PDT)
Date:   Fri, 7 Apr 2023 12:34:53 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com
Subject: Re: [PATCH net-next v3 08/12] net: stmmac: Pass stmmac_priv in some
 callbacks
Message-ID: <20230407173453.hsfhbr66254z57ym@halaney-x13s>
References: <20230331214549.756660-1-ahalaney@redhat.com>
 <20230331214549.756660-9-ahalaney@redhat.com>
 <ZChIbc6TnQyZ/Fiu@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZChIbc6TnQyZ/Fiu@corigine.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 05:06:21PM +0200, Simon Horman wrote:
> On Fri, Mar 31, 2023 at 04:45:45PM -0500, Andrew Halaney wrote:
> > Passing stmmac_priv to some of the callbacks allows hwif implementations
> > to grab some data that platforms can customize. Adjust the callbacks
> > accordingly in preparation of such a platform customization.
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> ...
> 
> >  #define stmmac_reset(__priv, __args...) \
> > @@ -223,59 +240,59 @@ struct stmmac_dma_ops {
> >  #define stmmac_dma_init(__priv, __args...) \
> >  	stmmac_do_void_callback(__priv, dma, init, __args)
> >  #define stmmac_init_chan(__priv, __args...) \
> > -	stmmac_do_void_callback(__priv, dma, init_chan, __args)
> > +	stmmac_do_void_callback(__priv, dma, init_chan, __priv, __args)
> 
> Hi Andrew,
> 
> Rather than maintaining these macros can we just get rid of them?
> I'd be surprised if things aren't nicer with functions in their place [1].
> 
> f.e., we now have (__priv, ..., __priv, ...) due to a generalisation
>       that seems to take a lot more than it gives.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/ZBst1SzcIS4j+t46@corigine.com/
> 

Thanks for the pointer. I think that makes sense, I'll take that
approach for these functions (and maybe in a follow-up series I'll
tackle all of them just because the lack of consistency will eat me up).

Sorry for the delay, had some issues around the house that became
urgent.

Thanks,
Andrew

