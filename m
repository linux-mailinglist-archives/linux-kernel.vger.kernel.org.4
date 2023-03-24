Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB846C7FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCXOVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B4F766
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679667645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnzDi+NqezIzj30TzlAwQyA5PZl+1nUCphCEnDSjOKo=;
        b=ZqUgbxzRvHiQveeS+ZwPcaxkwrKUF/vy9C9akeDRXPtM4/qszllK9RqaKC+QPbE8KDjlef
        Afk09juDNWtcnmMD0iMAUOyw2cnzPnYpfjlwNQzHq8o3Ls6Y2MnSYKxQ56F63JssO2iwE6
        cSO0hlvE/2dQTX+rkL3mfd9536ujRtA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-YZQ8hA_QPk69_Ol5nFRkpA-1; Fri, 24 Mar 2023 10:20:44 -0400
X-MC-Unique: YZQ8hA_QPk69_Ol5nFRkpA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5458dde029bso20083507b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnzDi+NqezIzj30TzlAwQyA5PZl+1nUCphCEnDSjOKo=;
        b=xI4wLsE4PhYIyne+t/B12omB0tzOR1y837QZrh08Hcg3qNmBomu/SF6Is3olvqow8s
         4YLBasXhadk9yJ04whI4G5rDpb/UIcPiFuLAbDv+1s3ZVW9dFiG5rESAHGxGSlOyW8zm
         UEt8w8bXVK0VSMF8ySvaXDgdxbWKZE9hUIJEMkfBwYRJzPHDMS9CjjIg6l62objpHqc7
         g16Efv50Yg+5eqnOyjwz2G4s8ByLlSzjmT219WuW/gMTvu2wCIDH1OVY9xm39SQ1Xcsk
         M/CLu2V9mwos/7ip8yhAAldc9BMClvgWBCKn+jQJQER41JBlFsVNm5Drva+ZJCSZTLKv
         APgQ==
X-Gm-Message-State: AAQBX9fbC/iOK0350TiquAltY3u3beRWEr+iuKVv6ZiZLDd07zXpuAxL
        DdSUe0MlY8l+s3bNkvmwypYNFij/wkMElqdGPsGYfH6VDNtxlfs1v2Ln5wQHtEa9SFRaHWWQBNp
        0lUWtojKnYnOfrg1ZHIzCjqKJ
X-Received: by 2002:a0d:d70d:0:b0:545:4df7:e6d8 with SMTP id z13-20020a0dd70d000000b005454df7e6d8mr2077834ywd.37.1679667643809;
        Fri, 24 Mar 2023 07:20:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350bOk+IVj59BKgVyLBC02gsDO0uRYN56xqvuWClOuK/BWAZg4hBomqKvs26vGNkH2c+4gWyK8Q==
X-Received: by 2002:a0d:d70d:0:b0:545:4df7:e6d8 with SMTP id z13-20020a0dd70d000000b005454df7e6d8mr2077816ywd.37.1679667643539;
        Fri, 24 Mar 2023 07:20:43 -0700 (PDT)
Received: from halaney-x13s (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id r131-20020a819a89000000b00545a08184casm427122ywg.90.2023.03.24.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:20:43 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:20:41 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Message-ID: <20230324142041.enah43shuppu6hg7@halaney-x13s>
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 06:34:06AM -0700, Douglas Anderson wrote:
> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
> prompted the us to switch to synchronous probe showed that the root
> cause was a missing "rootwait" in the kernel command line
> arguments. Let's reinstate asynchronous probe.
> 
> Fixes: 58973046c1bf ("regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS")
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Thanks!

