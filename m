Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA96ED06C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDXOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235F61AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682347142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BigudKcOA1SWNAOg8hWRkq+6kqvUQ8WQtVHc52aXCFk=;
        b=QdlHiYhZTLpqw49T+hhMgSsurWxT/MDTOLh8N2V9LB8T3If1qI5chWQ/j13V39UQjD957Q
        WbV7csIHADxzuks6I9WXI0G2kM3r6YLIJkK/lj37QP2yZfhsxXBrEQWuQe4fiMfi7PjZwD
        eW5tDa8ouImHLQ8JlIxu7dnpbGVJsP8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-xhNfswAROjC-cRaQpwCiCQ-1; Mon, 24 Apr 2023 10:39:00 -0400
X-MC-Unique: xhNfswAROjC-cRaQpwCiCQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6a5e616d5d3so4080492a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347140; x=1684939140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BigudKcOA1SWNAOg8hWRkq+6kqvUQ8WQtVHc52aXCFk=;
        b=Sj1EGSfDtPz/2WWUcT764zB3dIoNjWEqdtErXDVOtemPJuoQf92UTtQiZOt/W8RouO
         9AbzyF66znYZgaKBikvxzKpSwDPANRflGSy3e2kLKscPwHIP+xIY4skSYdm25I+Dac3D
         Ql98EClmHsWcMw7pKu8INspKcCprJcAmdwtIruWPr68cSd16puVgBfyUJ/bBnaf4u8Qc
         W5RiKbW6o9YmzbNa4Df+fhTUoaHPtXaWH5hHhHlBNS0bvs1GrcgBs1lOfM1M/5QhHQF5
         UWzS/mJCet7Xgjtwd8Jld5ClZeYGo18Z44lB0tIWAqkppzorgFtfr5QfpJOBeSi8BPmp
         TElw==
X-Gm-Message-State: AAQBX9dFbadCsX1SG8j9CmBldvi//DVfZZlH1yToBdokLV/IrM5u72vO
        4YGXgMeuiu2CbJSupvT+jVu/H22yuTiEbpqKaSeKSBgCFYHo4WYcqew4EwTZj9jfw/boF44w4HC
        0zt8DChDYUBGj+CG+Se28qadPu1ML5gGe
X-Received: by 2002:a05:6830:1603:b0:6a5:f6f6:4ebf with SMTP id g3-20020a056830160300b006a5f6f64ebfmr7763131otr.37.1682347140017;
        Mon, 24 Apr 2023 07:39:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350a4cPtmKSKYUPwFELwY06yqIRsIWSQ/yGP+ZB1JxXAGRtizSylDhCPYxVdKzDUhmtvHwVE2aw==
X-Received: by 2002:a05:6830:1603:b0:6a5:f6f6:4ebf with SMTP id g3-20020a056830160300b006a5f6f64ebfmr7763119otr.37.1682347139827;
        Mon, 24 Apr 2023 07:38:59 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id z18-20020a05683010d200b006a32ba92994sm349236oto.23.2023.04.24.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:38:59 -0700 (PDT)
Date:   Mon, 24 Apr 2023 09:38:57 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sa8155p-adp: Make -cells decimal
Message-ID: <20230424143857.373kjvi42c7acsbp@halaney-x13s>
References: <20230421205512.339850-1-ahalaney@redhat.com>
 <20230421205512.339850-2-ahalaney@redhat.com>
 <abd106b1-6650-6a7c-1c8b-3609e47b0161@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd106b1-6650-6a7c-1c8b-3609e47b0161@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:21:45AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2023 22:55, Andrew Halaney wrote:
> > The property logically makes sense in decimal, and is the standard used
> > elsewhere.
> > 
> > Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > 
> > Changes since v2:
> >     * Collect tags
> > Changes since v1:
> >     * New patch (Konrad)
> 
> Doing such changes per one board will be a lot of churn...
> 

Agreed, are you suggesting I drop this patch (and if we do this sort of
cleanup to do it in bulk)? Sorry, not entirely sure I am picking up what
that comment is implying.

Personally, I'd prefer to keeping that patch as this series is trying to
clean up the particular ethernet node.. but if the purpose of the series
was just to clean -cells up then I'd go with the bulk approach.

So as is, I'm going to leave it like so unless you have specific advice
against doing so.

Thanks,
Andrew

