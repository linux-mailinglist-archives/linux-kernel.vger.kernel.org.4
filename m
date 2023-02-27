Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7345C6A4671
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjB0Pty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjB0Ptr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:49:47 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D161ADF6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677512945; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Vozj8rdackxudhL6CoFfy9qaUxqW5k+9uKSRrA0BZDhwFYscW0FASQ9N/wQK3R9CajHXi1TrknhYyU0B/leFPN7k9/nrFY8A+3gQFF38jIl/JPYK6Dko5cL4jTbooS2IjS1XPjv8nMUe8AuY7QNqmfgsxNSQKpeZ5Fva1Xfbd3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1677512945; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LufG+uGg74qyMm4+3mt3r51M+Qw9SOQD3mty9YaUoo4=; 
        b=Y+2PueQ9mE53Fb3fwyPbPFYbevnf+qXolOlK13ZyVrTLg2saZq60REjcTrFNsr2t2rmwq2002exRieC7AG2XizoLX3F7s6qP7MXR1ykKsJQwGxLkpRK/Qb2y092l9xpt8p4djwo3FftTq21qDZVN0hESTmOjKZ1OHm7GrYncfKg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1677512945;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=LufG+uGg74qyMm4+3mt3r51M+Qw9SOQD3mty9YaUoo4=;
        b=tTqxAZaNQ7Mkinn21JCEnoRL5Gc31kMdrKKk81Sdla0eaJVn7dYrWCN9/kIF84c6
        YhYoCyMx8n7+LJ/DF0uQ/axy/R381eKO0/x5KyqOw7qR94ESnd7wYhVUgZdB8g1OC81
        P9saw2rO2MZIcFRTmagH5iK1XnDnpNQy0qJBugqc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1677512934260114.46478153909891; Mon, 27 Feb 2023 21:18:54 +0530 (IST)
Date:   Mon, 27 Feb 2023 21:18:54 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Jani Nikula" <jani.nikula@linux.intel.com>
Cc:     "maarten lankhorst" <maarten.lankhorst@linux.intel.com>,
        "maxime ripard" <mripard@kernel.org>,
        "thomas zimmermann" <tzimmermann@suse.de>,
        "david airlie" <airlied@gmail.com>,
        "daniel vetter" <daniel@ffwll.ch>,
        "jim cromie" <jim.cromie@gmail.com>,
        "sam ravnborg" <sam@ravnborg.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "dri-devel" <dri-devel@lists.freedesktop.org>
Message-ID: <18693900367.2ce71ba5548919.6872574648582795181@siddh.me>
In-Reply-To: <87ilfn30li.fsf@intel.com>
References: <cover.1677395403.git.code@siddh.me>
 <89f0aa1f26696846c2303527fe4d133bb4ff4bf6.1677395403.git.code@siddh.me> <87ilfn30li.fsf@intel.com>
Subject: Re: [PATCH v7 1/7] drm/print: Fix and add support for NULL as first
 argument in drm_* macros
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 15:13:21 +0530, Jani Nikula wrote:
> First of all, that's two distinct changes in one patch. The subject says
> one thing, but it's really two.

Sorry, my bad.

> But the main question is, do we *really* want to let callers pass either
> struct drm_device * or struct device *? It will be type safe with
> generics, but if it's okay to use either, people *will* use either. The
> call sites will end up being a mixture of both. You can't control it. It
> will be very tedious if you ever want to revert that decision.
> 
> Do we want to promote a style where you can pass either? To me, in C
> context, it seems awfully sloppy and confusing rather than convenient.
> 
> I'd argue the struct mipi_dsi_host stuff should use dev_* calls
> directly, as it's more of a special case, rather than allow struct
> device * in drm_* logging macros.

I agree. I thought direct dev_* calls would not be ideal, as there is a
TODO to move away from that, and also incorrectly expected to have more
such dev ptr problems. But on a second thought, you are correct.

Should I post a new patch, with using __drm_dev_ptr instead and
removing the __get_dev_ptr generic macro, and using dev_* in
drm_mipi_dsi.c as `dev_err(dev, "*ERROR* [drm] <msg>", ...);`?

> BR,
> Jani.

Thanks,
Siddh
