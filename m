Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329C6B1ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCIFjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIFjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:39:03 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812978C811
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:39:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i5so898669pla.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678340342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhklRBnV/Opvy0t0Yzw2NCc36CUqt3IMSPiX/GAGA6Y=;
        b=d1pBPwwx/G4iR3gkX3fnB3XsruRKN1m/HearGIjGkz70oU2uG2d5Cc+9aBqng1jpjc
         4UKUclTyaZTr07yHOtmIHAbGrNYlTFpIqL0aQIuUjJntlTPpSKg+33tOuoFjsDgQlLgp
         l6NiLXIi3aF/UFMrx4r2l9Q1ehF8lKXeWEHho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678340342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhklRBnV/Opvy0t0Yzw2NCc36CUqt3IMSPiX/GAGA6Y=;
        b=CUgmilMN7jcSr0XdnmGGn3E3TZPXsFtd9wt9+bfS4mMSJypWvHhK8Cq7A5qm9k/ASG
         oghgsx4Jbdo6H61B4PXPMIB/b61c4veb9FEVmMvLtejbJ+9seC1JyXIgK7nyEsu3ePSP
         MhyvncxFuSgJERIkUNc3pjYHys5QGaP2ECz5McmVNcAC4BRuwLqDLSiXZEuh2m6GyjTU
         87oD4r9ABDS4NtUaADx4eEy+Rg7FvpOCUdeMt8t3YZWFtA2wCuCF0GXmwOk/l6QovjJU
         3NJZkpt12s2g16SCzEidhC/WaoP2Nsu8A7NAUXOrcIcPNVjq1GJnfg5mXtVB6hXuV/bp
         5U7A==
X-Gm-Message-State: AO0yUKXXZSWO1MeT4OC2S37VdAOo87duXcwPhP3TF2onBxzLQHEDbaGl
        4fnWd0NAGoAXyJwTf+jA94WH5g==
X-Google-Smtp-Source: AK7set+/kUGJJGVbpRECA/8RazumSkR7LCsi9LhXnm+HBiRYykSCjWb+JBFQyAemQkn5eBhSoInSXA==
X-Received: by 2002:a17:90b:3c49:b0:233:e1e6:33d4 with SMTP id pm9-20020a17090b3c4900b00233e1e633d4mr21168440pjb.47.1678340341959;
        Wed, 08 Mar 2023 21:39:01 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090a708200b002310ed024adsm677060pjk.12.2023.03.08.21.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 21:39:01 -0800 (PST)
Date:   Thu, 9 Mar 2023 14:38:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/5] media: uvc: Ignore empty TS packets
Message-ID: <20230309053857.GC1045797@google.com>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
 <20220920-resend-hwtimestamp-v5-1-139d1a144614@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v5-1-139d1a144614@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/08 23:45), Ricardo Ribalda wrote:
[..]
> +	/*
> +	 * Some devices make a borderline interpretation of the UVC 1.5 standard
> +	 * and sends packets with no data contain undefined timestamps.

A nit: can this be reworded? I'm having some issues with interpretation.
