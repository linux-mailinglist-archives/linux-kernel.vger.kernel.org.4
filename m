Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA260C89A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJYJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJYJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B3A3B48
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666690972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=009tOQY1pEpt55WIVbDxZ7SKtqEP3Ivq5Fnobayrx5Y=;
        b=GQAy4OJkofbNsgYym+rL/qsnbdMfyJT+LFvIYEjK80ODIxr3+1DqvTgHo5W2clEnoP/d5K
        TrLN9ferqVeH9YByMgLdPE7tSLdLrHbIsLtNo5mIzK0gkUKzKPis4B4XGfaqmNatoQwidD
        sZeMiy1BoN4eDaPevNm1SUTEJUB5r3M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-YoHRHlTJMZKkd10oMWSx8A-1; Tue, 25 Oct 2022 05:42:49 -0400
X-MC-Unique: YoHRHlTJMZKkd10oMWSx8A-1
Received: by mail-qk1-f197.google.com with SMTP id q14-20020a05620a0d8e00b006ef0350dae1so11013784qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=009tOQY1pEpt55WIVbDxZ7SKtqEP3Ivq5Fnobayrx5Y=;
        b=py2hBESxLbUHNmsG9StXLfP64ezyX8ZI6YDnyZ/aLzdxcC5LaBa+N9vCA+EmsNcKjB
         TKXuEKh9u6fJEqhh7BalMFWb6NixXUiMJr7v3oL5bTCbkBF7kCih72VKTnqrBThafcCa
         XOVYosdOJYpE3sHlGPLCQOHcc/PLZp5qWlNlxudhwcHtuBevZoIdcJpOiSVfgddmnXSG
         GO/AqR1bTdnrS20goeMaB57fck/cokrd5GBgtWd+F3Pw3mernfm8paZ/HRweUn4dfGym
         8/FI0egGzlgqoc3p9FLE53+mP4+hfbGLEsSM/g2fBTiFA3Sq+dnt9TzN3iXvIyLmb4Fp
         XgxQ==
X-Gm-Message-State: ACrzQf38RQhSuaJ9Zzp0MTyyFab5HWz8wU8aHCy0CIpbwlsgM65nWbp6
        ZGueylfW2ZtUO80sX8adqJLDtSnmM1Y3OL/tp8YHQgX872jWqok+bf7QJm0X2w/VT1qhkGrhAyK
        Y5ytKHHwglwNdGFgz+ryBsIJR
X-Received: by 2002:a05:620a:6ca:b0:6ec:553a:cf33 with SMTP id 10-20020a05620a06ca00b006ec553acf33mr25079115qky.132.1666690968934;
        Tue, 25 Oct 2022 02:42:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM458JHym0rUNU9OHEgKvafM8kNNE6FSbYT0/AafBWNBcAUJHt9wHV9O/2+KV6X0IcmESYAK/A==
X-Received: by 2002:a05:620a:6ca:b0:6ec:553a:cf33 with SMTP id 10-20020a05620a06ca00b006ec553acf33mr25079109qky.132.1666690968739;
        Tue, 25 Oct 2022 02:42:48 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id bn1-20020a05620a2ac100b006ce3cffa2c8sm1687588qkb.43.2022.10.25.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:42:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 0/4] workqueue: destroy_worker() vs isolated CPUs
In-Reply-To: <20221004150521.822266-1-vschneid@redhat.com>
References: <20221004150521.822266-1-vschneid@redhat.com>
Date:   Tue, 25 Oct 2022 10:42:46 +0100
Message-ID: <xhsmhfsfcw86h.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/22 16:05, Valentin Schneider wrote:
> Hi folks,
>
> I haven't sent an update for this in a while, but the issue has risen again in
> some other environment so I'm getting more reasons to push this out.

Gentle ping.

