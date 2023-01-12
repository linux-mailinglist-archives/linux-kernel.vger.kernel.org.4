Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99066864A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjALWCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjALWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:02:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78477718B3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:51:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so21592833pll.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWezmmHa6oj6qJtMomh+1hZZGWqGQrSyq0C7qN1MANE=;
        b=NrhE8GeB0gPtUpLJmL0nObCWCBwo04pER0QWC7YeN486f0tyfa3g3S7BtDUHlIbXFW
         zwrs+/K+DcCOmOq9CHZZri2ktplzmFfjR3ymQ4DGsJ6K3GoZmmlnw6aXM90nHdEUvKT6
         K3lDHI2HhmuViAyN/43XcHXcUD0CiNOTpAm0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWezmmHa6oj6qJtMomh+1hZZGWqGQrSyq0C7qN1MANE=;
        b=2WiqqpeEdvK94SjV/+OeZ7KqO8fi767jKWVflFqzfXS5XRRzlMr6xlwDmNRcTQiN0m
         pIh2YlBs+muoE7/O5ALmMwD6nGAIPQ42HotT4g3YXCbOzPopVScuzej8+h3dXiHnAIyF
         xQ0EnQVdGawUc9nAcvzGUGnH6HAsOtYqDgmI8lFPFjyHfVPuN3RkQ/4sCM0fyjZ9MZBa
         HnbeOZlkk/pQxzHMkHF//FmLdX1myC3f+9HXQCO1+5pZ0SLAjl1MVJJAVjxxsFLKs0/W
         gAs7B0hd0vyYcHHpv/Mz+8JOviZZvX6y9Ti1nMQhMGu2g2sASUrDl/bTKWBfxV6R4EpX
         L7jA==
X-Gm-Message-State: AFqh2kpwGRuYcFe4p9E/ZZ/twOHgBYrljtJWv+7f439cKtiBqj8I0SeD
        7DJc5hFnWZ83cisUBc3CfS+l3w==
X-Google-Smtp-Source: AMrXdXvH368zgSN+CqWpi3idJyL7uyuYLfW6YfP3XhLcEJ233wBi4Eh2ch09l2nZrresK14l3RKZWQ==
X-Received: by 2002:a17:902:ba82:b0:189:86f0:70a2 with SMTP id k2-20020a170902ba8200b0018986f070a2mr37242231pls.43.1673560277885;
        Thu, 12 Jan 2023 13:51:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0018bc4493005sm12607234plb.269.2023.01.12.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:51:17 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:51:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>, mark.rutland@arm.com
Subject: Re: [RFC][PATCH 2/6] x86/power: Inline write_cr[04]()
Message-ID: <202301121351.B0CE02B@keescook>
References: <20230112143141.645645775@infradead.org>
 <20230112143825.644480983@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112143825.644480983@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:31:43PM +0100, Peter Zijlstra wrote:
> Since we can't do CALL/RET until GS is restored and CR[04] pinning is
> of dubious value in this code path, simply write the stored values.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
