Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F86B4B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCJPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbjCJPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:49:47 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1DA4D617
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:41:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so9438328pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678462908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy3JW3n9a29iqNLw2r42ZAxFid5Jn9iGSQowne5RcPw=;
        b=wafpRt78bwVJFGLk0GT5A8Bxpt3o7PHi4IRqMfcWc36iN1mdWEtCoOaFfjQWOKirGu
         NDLNJgR1L6pBha4PgyWYJcBe0LgUp00WjQHZDtzSCUkfCW4lU7BLvefAHPnNGOlPX+cR
         somVJ2F2MNQOTMKqX3CHak9vJvluya4hxtO6SxKWnUI6Rdsy+ZqkKv/1uF3yoT60TMNB
         Vyf1aZWc6yqMr2q6RrfxhBilK1jJ674gxJFW06cU1gXUdtDeHVBRqW8bZi2LBaRVBUF8
         9UDLuoixMT4Mlny/zdD1oAcHwUoIHcXtAtU2NshFNjhCOKbPdCaKpMHDzrWXTaZ4hV/v
         PtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678462908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy3JW3n9a29iqNLw2r42ZAxFid5Jn9iGSQowne5RcPw=;
        b=UZrwKD6QURmSClXjjETUfCk1AhKZk4qdLg4ou8du5AlkT5TnCj3VwMUDWNFsnocpeZ
         win3zU1yiGYUqjs7/LePZt3O9zjDlCoTth/yUvdx8B/YqEDYWxVbeXIPPIi12gFVlCYq
         oARUkz/J0Iqt5VBkffqg3vKngg4wOG3Hx3ZAfsVxQ3T6bRF5CvbC9oUZTe/3UkIhlFdK
         c6/jtrkM/eb+zWe/qD1RTAxfjeSzb4Z5IIpb227nY7X/gLnEc7tQ+lNK2mDjhLpBdCVv
         TAWUQmUkmYbqz3GPEYCW0OvHQzq8UBfUkKcEkGxalGcsLiFf/jLHyYCHe+xaYIaRkZ8b
         JkVw==
X-Gm-Message-State: AO0yUKUiGo3dFS2AQon9yCtceewRcVTKj6O+KXiv9ADqtLzgGVA4aqq2
        BoC4pfBWYfvgWu1JLclolF+XSQ==
X-Google-Smtp-Source: AK7set9bbjp3EtckUC9P5mNZ+dZcmgFRUQgqL0Ap9imHD319D6qEIsesjhYOjI5p0c3ya7Bt3lAXDg==
X-Received: by 2002:a17:90b:3b89:b0:234:ba6f:c980 with SMTP id pc9-20020a17090b3b8900b00234ba6fc980mr27744864pjb.17.1678462908166;
        Fri, 10 Mar 2023 07:41:48 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:233f:47c4:de18:a4ba])
        by smtp.gmail.com with ESMTPSA id lj9-20020a17090b344900b00234ba1cfacbsm123980pjb.17.2023.03.10.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:41:47 -0800 (PST)
Date:   Fri, 10 Mar 2023 08:41:45 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: remoteproc: k3-m4f: Add bindings for
 K3 AM64x SoCs
Message-ID: <20230310154145.GA1882384@p14s>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-2-martyn.welch@collabora.com>
 <20230308205833.GA1768401@p14s>
 <8662e02b-9d28-8ffa-6ec2-5cc6348933fb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8662e02b-9d28-8ffa-6ec2-5cc6348933fb@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 05:18:01PM -0600, Hari Nagalla wrote:
> On 3/8/23 14:58, Mathieu Poirier wrote:
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - ti,sci
> > > +  - ti,sci-dev-id
> > > +  - ti,sci-proc-ids
> > > +  - resets
> > > +  - firmware-name
> > > +  - mboxes
> > The 'mboxes' property is marked as required but the description section above
> > clearly state the M4F can operate without IPC.
> > 
> Well, when the M4F is used as a safety processor it is typically booted from
> SBL/u-boot and may isolate the MCU domain from main domain/A53 to function
> in higher safety level. In these scenarios there is no remote proc handling
> of M4F life cycle management (LCM) and IPC. But, on the other hand, when the
> M4F is used as a non safety processor its LCM is handled by remote proc(main
> domain) and mailboxes for IPC are required.

Well, what you wrote above is pretty much explained verbatim in the
"description" section of the bindings.  Mailboxes are optional and as such
should not be found under the "required" section.

