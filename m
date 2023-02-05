Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7768B229
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBEW1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:27:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179E713D75
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:27:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id iy2so209516plb.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9KGZEzYN7ZDj6+qcO8JuGU2wVkzt6LA3vh0FoiBL8I=;
        b=kJTIXUn6tQKwop2HkFxGU39WF7b7ONxi6B+K0bOLoc+no4Ixuh4W8QHJ4Cm0OiDhs0
         xvdK7RMc8+PBXjSqPjS5mvec2v0qBezwVtMG1uB0XJq6UaL195G3LOJTbfcOUKcMzRrE
         E/aKbEIgug9RK/G5u6ZoWeFvjBXiomBzltYtWRfmEH8Xk/Imme94zuFdpMhtmqpW4J4M
         /kTCrnUnnxxF+x8ajbgBd+YXVl4CCCx1S23eWc517KcexFdC3XiaKNNCzYgOQEqMY0nh
         XkSzvbdjvFKaXvQOjQkUelXzB8vGD5pO3TUq745wHE5RsL68PDgSI/9UvWdo/zvsGsDQ
         JuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9KGZEzYN7ZDj6+qcO8JuGU2wVkzt6LA3vh0FoiBL8I=;
        b=qayTjwH7pYkWdpMFDbCMnMYNROFAQa5GaSkdAL933snSX1l3CabLlmAVE3s47w9oEZ
         hQ8sFnbq1ZilOIjdzCj2Jrk/WAqBErg32qcqD51OB0uSYcNn9/2JOE9LWF+Y/4wcVTmg
         E7DmzWsyielQGQq0SMDlzY6EF8Ve+yWPVctnHgqu1C53+hXdudHo6QgWF64k4yeLKL4z
         ZTd1bIpgQMWnZRGaTEgOP62oLIU2UngBQPK3tEeDWTV5AE24TrcRxPyHDAYKMX/olGlP
         +1MHTzzAuACzlaLGXC/zYWruDTR7WJm2rOfD2lxc4EP04dH4FTFs1nxPP7SbDFJIS+52
         9jPw==
X-Gm-Message-State: AO0yUKVpl6F4joi4ICoaGz7I9tL1c16qUJq9Uc+zQGLtAGbLZlpoLkJy
        LY9Bzfn0xqw5F6Dc5vBCk2jGjA==
X-Google-Smtp-Source: AK7set9Q3GIqNsOe0WtmgFYF0XaEvPUObr4qRanVRrqj4E3ykA/3NP+u6IgYx0VUnzE8Gq/5xI+Ikg==
X-Received: by 2002:a17:902:f0d5:b0:191:4367:7fde with SMTP id v21-20020a170902f0d500b0019143677fdemr329089pla.0.1675636058414;
        Sun, 05 Feb 2023 14:27:38 -0800 (PST)
Received: from chino.kir.corp.google.com ([2620:15c:29:203:fa19:a2cc:781:3452])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902cf0b00b00186acb14c4asm5376025plg.67.2023.02.05.14.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:27:37 -0800 (PST)
Date:   Sun, 5 Feb 2023 14:27:36 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix memory leak with using debugfs_lookup()
In-Reply-To: <20230202142022.2300096-1-gregkh@linuxfoundation.org>
Message-ID: <b024023f-b1f8-aedf-676a-5ee517f524a7@google.com>
References: <20230202142022.2300096-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023, Greg Kroah-Hartman wrote:

> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: David Rientjes <rientjes@google.com>
