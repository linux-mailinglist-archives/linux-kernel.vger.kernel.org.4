Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891C262214C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKIBWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIBWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:22:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4D45F85D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:22:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so453729pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 17:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/7LWEJz0+L5ZmpQmdaQTLywAe07bO1jBNMRgwCToFg=;
        b=JC3ABDrxqqlvCMQDvshcXI7nRZ2IAs+p1gg9FcQkt4gMOI9VtHZp/D/ggc8GJnMbX3
         57F+7cto25IxlIv67TdOLlFXUpyGUJ8+EOqmQqRAtQvOBoQi58h9QNCO775JiLmnaA/P
         pQLrbKtIGYQLLa//xuwYo1MAQiTjan98e3oRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/7LWEJz0+L5ZmpQmdaQTLywAe07bO1jBNMRgwCToFg=;
        b=im9qz2mNSMFcBqXmmhJl0qh8OHzfXRFHV7+mwih9E+wGr5wzGK4tSNM8cfTR8GDTuN
         7/1v6fDrnDorAXKcB1gFfPaJJQuq4DvirFFXnbN986P/XTU69aeH05thkX1MynVOImVI
         l2XgQDWOYsV0YJz94VQym4/P5qXsVqmoxHAlZeeh7ZKT3RR1ZqtCeChP2JnAXeLkvnFM
         NgRpylwiIycQXQ8A7SaqUpJh/VlCyFBrw1eHMT8dUxns/DZyMKRIkwyvWpB6vT1DkLb0
         RkMFfAGmnD3LjMmSjX4MwEWnzAvPzgNj3gV9MLPTiXV3WkXVwV9rjdT+p+9rrE54WEbA
         Djkg==
X-Gm-Message-State: ACrzQf0nvngegeLzDcmUkhUl3eYHx6upOyf5zAc0Oq1jho1K4z/Cp6eq
        ZGueWSZ/vIjQJFLuClM5XL3er/womiYtxg==
X-Google-Smtp-Source: AMsMyM79wV03PeOCgAWiXl4AktoLEnB0mGs99UWHXE5f72dWr3bJFMGh0MaQKuBmpYynGlRLpU9/BQ==
X-Received: by 2002:a17:90b:2393:b0:213:ecb2:2e04 with SMTP id mr19-20020a17090b239300b00213ecb22e04mr47944640pjb.100.1667956924038;
        Tue, 08 Nov 2022 17:22:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:953c:d63a:4da6:1064])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b00174c1855cd9sm7545805pli.267.2022.11.08.17.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 17:22:03 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:22:01 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Move racy global PMU list into device
Message-ID: <Y2sAucYLR4FsGIfc@google.com>
References: <20221028224813.1466450-1-briannorris@chromium.org>
 <6e237301-9c30-a463-0f28-5279e655646a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e237301-9c30-a463-0f28-5279e655646a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:50:04AM -0500, Felix Kuehling wrote:
> While you're making the pmu list per-device, I'd suggest removing adev from
> the pmu entry because it is now redundant. The device is implied by the list
> that the entry is on. Instead, add an adev parameter to
> init_pmu_entry_by_type_and_add. Or you could move the list_add_tail to
> amdgpu_pmu_init and remove "_and_add" from the function name.

Sorry if I'm being naive here, but does that mean trying to navigate the
list pointers to move from a 'pmu_entry' to an 'adev'
(list_first_entry(), etc.)? There are quite a few cases where we're
trying to go between 'pmu_entry' and 'adev'. I guess I could turn that
into a mini helper.

I'll also need to scrounge around a bit to see if I have an amdgpu
system around that actually supports PMU. I realized the one I tested on
doesn't actually hit this code path... and this would be getting a
little less obvious/trivial.

> Other than that, the patch looks good to me.

Thanks for looking!

Brian
