Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB65B6E094A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDMIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDMItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:49:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7E83D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:49:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso254002a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681375772; x=1683967772;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sijaRA9csYHk+QDl9FlXYhGP0StlKpy6z7FBZEoJClw=;
        b=PtDHsAiBZg/CrfdW3+ViNTDgGocGht9q6tphOmmpvcKYVA26yrLmlRSS9u0gHI/Zn/
         DJOEh/zzXqpQY/9EC6TjRXIjgyJnqy1hTaulP5abma4jA/I6MlK5HR/jqX1Q9ebsd4xi
         ebwSCmGQb+oaEOG2RbDfHhqQETur6Wy+XrcYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375772; x=1683967772;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sijaRA9csYHk+QDl9FlXYhGP0StlKpy6z7FBZEoJClw=;
        b=BFO0oS8MbHjt8dMzt5iR3Dl1Uco1sZIrEXZMWNEsn+h3seLmjEUyq2yI6eVFMz8kBq
         hmW0PoGPStTZ7ra0jxWDxQtdJ52UcH8KeC64n06yGaF3RCpgUru0wqdJ9SBBI3UZ0IWE
         wFinUoQ+UEzSquSlrcQd7zrVbxKqriVSE2igyx8TUbEzv/JpCx7JjC6vEBh/CUBLQ0WS
         eRx6Vo9TQ33f7Tlbu4d2ZKtJpxGbm6C57ulb6dGq0fQRPPHLPGhXYL9DJaHFpf7hvOeh
         pzY/lNVGaYzDo29GhDht3DhgbFUvbfKE2DEoWyAPgGh4tI02RAU9ZMX4f+50Mz+QP8aK
         ugmw==
X-Gm-Message-State: AAQBX9e2niZjh8pljbhq3S06gt/vLGFjUurupCduX5uUSpjGdS8Z9PI3
        DIT0XE7jHjGYpuUj64Euz2bBGw==
X-Google-Smtp-Source: AKy350aUV1nyhnQwiZ5Apo2QV3oDfYQiO15+DXNmy9wUYEy48bG3MnWmMH0L0drTzlm7E6J8N0pT+A==
X-Received: by 2002:a05:6402:518d:b0:502:367:d5b8 with SMTP id q13-20020a056402518d00b005020367d5b8mr1839707edd.4.1681375772088;
        Thu, 13 Apr 2023 01:49:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id j19-20020a508a93000000b00501c2a9e16dsm552679edj.74.2023.04.13.01.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:49:31 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:49:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>, daniel@ffwll.ch,
        sfr@canb.auug.org.au, mani@kernel.org, greg@kroah.com,
        ogabbay@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, quic_pkanojiy@quicinc.com,
        linux-next@vger.kernel.org, jacek.lawrynowicz@linux.intel.com,
        airlied@redhat.com
Subject: Re: [PATCH] Revert "accel/qaic: Add mhi_qaic_cntl"
Message-ID: <ZDfCGXPCFkb20jNW@phenom.ffwll.local>
Mail-Followup-To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>, sfr@canb.auug.org.au,
        mani@kernel.org, greg@kroah.com, ogabbay@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        quic_pkanojiy@quicinc.com, linux-next@vger.kernel.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com
References: <1681307864-3782-1-git-send-email-quic_jhugo@quicinc.com>
 <20230412140542.GA3141290@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412140542.GA3141290@linux.intel.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:05:42PM +0200, Stanislaw Gruszka wrote:
> On Wed, Apr 12, 2023 at 07:57:44AM -0600, Jeffrey Hugo wrote:
> > This reverts commit 566fc96198b4bb07ca6806386956669881225271.
> > 
> > This exposes a userspace API that is still under debate.  Revert the
> > change before the uAPI gets exposed to avoid making a mistake.  QAIC is
> > otherwise still functional.
> > 
> > Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

I think Ack from Oded would be good (but iirc there's some holidays going
on), but I guess Greg's is good enough. Can you pls push this to
drm-misc-next-fixes (it's open now for merge window fixes) since Jeff
isn't set up yet?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
