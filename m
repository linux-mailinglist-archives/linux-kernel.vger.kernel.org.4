Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E673716917
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjE3QUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjE3QUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:20:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3D93
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:20:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5208be24dcbso2946031a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685463651; x=1688055651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf4YK7Nlt1xMm1TWJQkBoFqPmDurlTxDp8HiK/k4M8k=;
        b=VjGC5EGOqpWtBh+mIxKe7Jr2JgXDaZaiVvkxKwrmhnXgWfX8Vxd90dSarJ5pyfyIG4
         DI/4s4lFuf929W4CVXxTBTAyblpUiNV9MG/mQAaZ8YLhccAmXasXKDV3JGSRg77PgFZf
         IkVKZprTL0nTEc9FQ9yhI8Fi65/hmkZt4rkQ/GsI3DXr4gC7kQ7apCemi6NhXu23gJfp
         qzBq0yqJ0HP7nEFCbNLZttq/HtbDMWII9eSidc0CR+JHEuOm4uXRd6gKzDb0FxsrrWWM
         z2N2D05S5LZml3cCs2UpK2IiFT63UMNoUo1v3rJwMN41Fk36hrhEzJy60Wr6NVhH6wFs
         HriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463651; x=1688055651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf4YK7Nlt1xMm1TWJQkBoFqPmDurlTxDp8HiK/k4M8k=;
        b=B/wG96pzcCdTCWmto1l1sBFzmJ1ncAMA3fx/E2PaPRcWFbPlK6TOKN6iqwm99vHo2l
         PxNNx6RnQlrqsrLOTjd2TSTPc1zczxSa1w9Cd4pVxdjUdy0C8SbWschlAINfVk4Paitx
         agL1Mf66aDNepDE5d97yzcd7Y5p9lLt0L7F1OJZKGbgGOPLgWykqhhWxYP+XF+TydRAy
         Gx3VHNRcHDHB7HlSlVFUCS8EZ0b9/Uc4StjeEUcrALodiPV15bZTDu/0jN+MHqk+VfCC
         Nk1bGJ1MpXYxrnSsfCZ7shKuRLmu578cI/H8EAHALsNVIL+jkOAf40nqXngdOIMzLJuM
         0jcA==
X-Gm-Message-State: AC+VfDxOxEvwWc6uKulnXeBKSXheooi87w4fC8YREb1vX4FxhDJt91tS
        SGflZhsCpQWYcXJS4sE/kL7vbg==
X-Google-Smtp-Source: ACHHUZ6l87ILYGpW4MUVWIF+xyHlCkMCs7tBbloFyheBZTZyYhcowO1DlaakYntogeCKPeP80JhOKA==
X-Received: by 2002:a17:90a:c695:b0:256:c44d:e115 with SMTP id n21-20020a17090ac69500b00256c44de115mr2309344pjt.12.1685463651451;
        Tue, 30 May 2023 09:20:51 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ec0e:68f8:4f49:7581])
        by smtp.gmail.com with ESMTPSA id a3-20020a634d03000000b0053f3797fc4asm8370567pgb.0.2023.05.30.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:20:51 -0700 (PDT)
Date:   Tue, 30 May 2023 10:20:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] introduction of a remoteproc tee to load signed
 firmware images
Message-ID: <ZHYiYGMHdqxBaDzc@p14s>
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:13:46AM +0200, Arnaud Pouliquen wrote:
> This RFC proposes an implementation of a remoteproc tee driver to
> communicate with a TEE trusted application in charge of authenticating
> and loading remoteproc firmware image in an Arm secure context.
> 
> The services implemented are the same as those offered by the Linux
> remoteproc framework:
> - load of a signed firmware
> - start/stop of a coprocessor
> - get the resource table
> 
> 
> The OP-TEE code in charge of providing the service in a trusted application
> is proposed for upstream here:
> https://github.com/OP-TEE/optee_os/pull/6027
> 
> For more details on the implementation a presentation is available here:
> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
> 
> Arnaud Pouliquen (4):
>   tee: Re-enable vmalloc page support for shared memory
>   remoteproc: Add TEE support
>   dt-bindings: remoteproc: add compatibility for TEE support
>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> 
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  33 +-
>  drivers/remoteproc/Kconfig                    |   9 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/stm32_rproc.c              | 234 +++++++++--
>  drivers/remoteproc/tee_remoteproc.c           | 397 ++++++++++++++++++
>  drivers/tee/tee_shm.c                         |  24 +-
>  include/linux/tee_remoteproc.h                | 101 +++++
>  7 files changed, 753 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/remoteproc/tee_remoteproc.c
>  create mode 100644 include/linux/tee_remoteproc.h

Looking at comments from Christoph, there seems to be a good refactoring
exercise in store for this pathset.  As such I will wait for the next revision
to look at it.

Thanks,
Mathieu

> 
> -- 
> 2.25.1
> 
