Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287667082EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjERNjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjERNjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181719B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684417131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/spM/Tt+6jY+bXguF/tdV1zzuEZPNfnHi37xmhV69Q=;
        b=FLz4Y+Q0YGMdcH2n2uQrETqLG6d+cDr5UVXDe7jf5e4xj5106kKNvovG/5WVMCwC9P92dJ
        VirEwGhSP69UIfF1RrbwnVg9TF8VwlGLF0MjNvodJvVvyFzWyoNv0B24T9QyopEv2EVmfh
        vRJ+Mxlklz6pybdiR5YVECIYWYjjjYA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-SVtK4aBLP9OGTLBCJgYSSA-1; Thu, 18 May 2023 09:38:50 -0400
X-MC-Unique: SVtK4aBLP9OGTLBCJgYSSA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f4dd7f13d0so8608225e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417129; x=1687009129;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/spM/Tt+6jY+bXguF/tdV1zzuEZPNfnHi37xmhV69Q=;
        b=HaJpTUL8WmoXaMbDDTgJ68G6ZrDtmWObOVTQ8P2Mlzok5KvtYE9w4bLNroBboQqDU1
         yiZ6s13Nrejwr5Gv4QXysQtnIpp/pVeNq2M2IvZJafhaDQ5HE/K+50rc+pPUYh94k/xb
         lJoni2MR8CIWtpocSKP77oZNIkLfgzMJa08/a1p3RFmu5Uai7xZiJ4XA8vKKh3GlHTGt
         7Vi2Eg8Up5ro3Nb6TLySYXuzl5em/+xwyEuabxEwWJB/mHql9mP0a5W059niUiv6VYc6
         smfaWgUPesEJT6Fi2RaGg2M/SCxldytjIFRt6Lu4WlCG9fY+zdbvI5OtF60RL1IiCPB2
         63VA==
X-Gm-Message-State: AC+VfDw4e+lEKihchdMXl1VZMmXurElrCVSrFmVRRBClSiimXiw+0A/S
        6ZLcRrp7WUaPq1spr1wjcHZP1Tcuass/omFG/ridj1ZY+H7EOie1EMnjujQA80J76+lmgYJjXys
        nblCOr+C7Pvm42KwOcESYBl48
X-Received: by 2002:a1c:7712:0:b0:3f4:ec32:6a00 with SMTP id t18-20020a1c7712000000b003f4ec326a00mr1688261wmi.6.1684417128967;
        Thu, 18 May 2023 06:38:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72CyHAxA1PHqON8S7LHeHP0dj3oljBR3Z7eTT6WFcf6Uy+cC37Rss03gIF1Dgg2MHI4JhoPA==
X-Received: by 2002:a1c:7712:0:b0:3f4:ec32:6a00 with SMTP id t18-20020a1c7712000000b003f4ec326a00mr1688247wmi.6.1684417128711;
        Thu, 18 May 2023 06:38:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b003f0aefcc457sm5509645wmg.45.2023.05.18.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:38:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dana Elfassy <delfassy@redhat.com>, eballetb@redhat.com,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH v2] Input: tests: add test to cover all
 input_grab_device() function
In-Reply-To: <20230517153145.513095-1-dangel101@gmail.com>
References: <20230517153145.513095-1-dangel101@gmail.com>
Date:   Thu, 18 May 2023 15:38:47 +0200
Message-ID: <87v8gp92u0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dana Elfassy <delfassy@redhat.com> writes:

Hello Dana,

> Currently input_grab_device() isn't covered by any tests
> Thus, adding a test to cover the cases:
> 1. The device is grabbed successfully
> 2. Trying to grab a device that is already grabbed by another input
>    handle
>
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

[...]

> +
> +	handle.dev = input_get_device(input_dev);
> +	handle.name = dev_name(&input_dev->dev);
> +	handle.handler = &handler;
> +	res = input_grab_device(&handle);

Another thing I noticed is that your test will try to grab the same
input_handle twice. So you need to remove the line above I believe.

> +	KUNIT_ASSERT_TRUE(test, input_grab_device(&handle));
> +

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

