Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23065EBFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjAENFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjAENEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:04:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD1C5AC7E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:04:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co23so36082370wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsZ32dv/OC+Nb4ftoKd68ybVYKMb6ALfR6sxEPmUBK0=;
        b=OMl2z0bEVkQjBng9NmxI8H9oWdCOX+1jSoysVqvl5eUq0fH3zSvu0BR5H+deKbN8kC
         rsyD2oEp3IZDcF1WGL7zVwvFUrMkRoxAcIg3Ofa5uc0GywdmZ67j83ZBtB4kPfJGsNyP
         Kr3CyQCHYSr0tCSdT9C0hS7z6Vb2IpNMetTLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsZ32dv/OC+Nb4ftoKd68ybVYKMb6ALfR6sxEPmUBK0=;
        b=tnkFc4r+jiC3+2cDbfnslgT7lQHxwR5wZUWEpYmFA2JvtdkG2g8Ut8Mr8Jxwk10uCm
         tvCfngIN1Bg3o34d+Tvi+5jX0PE5PQW0aFo9szt3JHtHvtYo9cr/bV+9z2inKW4lvmJC
         MevdN6oT4Bj3IW6Iga+8b+5uKvph9OWZMZHBl5NrKjBsb6lOtVSxqTrePR1Nag063LH2
         Uz3ONg4JE9oVx6ZYzCpzG2UgLERIqWDdat9DAFotxPfAMEGn1vU69OJuvZ1UNCTcCZ4O
         BF88tU4qTgmpxk7S9ESxqK9GslbB4Na+IToOo4btb9r+iCk6ekVREKyqkwJSN1fAFFbC
         NvOQ==
X-Gm-Message-State: AFqh2koyY/P+4SLwHiqetfFCE5dHBRdHDFY6FaTjELlZMQdiSmnrxfLh
        WpzT5FWaD+r0k4tmjaQ8aUW0I0OidmOiR/cN
X-Google-Smtp-Source: AMrXdXtFVgsClYWQ/F/H3Fu9zHMZcwy4NMo0QmdJvkOV/usH8nN5KK69iAUk4NcI/VpNOKleze4rpQ==
X-Received: by 2002:adf:e743:0:b0:242:63de:2f5b with SMTP id c3-20020adfe743000000b0024263de2f5bmr34768293wrn.6.1672923892964;
        Thu, 05 Jan 2023 05:04:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q5-20020adfcd85000000b002366553eca7sm36657442wrj.83.2023.01.05.05.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:04:51 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:04:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Andrzej Hajda' <andrzej.hajda@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/5] linux/minmax.h: add non-atomic version of xchg
Message-ID: <Y7bK8drngH/NIlOa@phenom.ffwll.local>
Mail-Followup-To: David Laight <David.Laight@aculab.com>,
        'Andrzej Hajda' <andrzej.hajda@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <f58ab17e5c6c4a4e8b0d687b44618c51@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58ab17e5c6c4a4e8b0d687b44618c51@AcuMS.aculab.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 09:38:12AM +0000, David Laight wrote:
> From: Andrzej Hajda <andrzej.hajda@intel.com>
> > Sent: 09 December 2022 15:49
> > 
> > The pattern of setting variable with new value and returning old
> > one is very common in kernel. Usually atomicity of the operation
> > is not required, so xchg seems to be suboptimal and confusing in
> > such cases. Since name xchg is already in use and __xchg is used
> > in architecture code, proposition is to name the macro exchange.
> 
> Dunno, if it is non-atomic then two separate assignment statements
> is decidedly more obvious and needs less brain cells to process.
> Otherwise someone will assume 'something clever' is going on
> and the operation is atomic.

Yes, this also my take. The i915 code that uses this to excess is decidely
unreadable imo, and the macro should simply be replaced by open-coded
versions.

Not moved into shared headers where even more people can play funny games
with it.

I think swap() is a standard idiom in C, this one here just isn't.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
