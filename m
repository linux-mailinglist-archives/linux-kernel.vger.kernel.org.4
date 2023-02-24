Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC606A2318
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBXURW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBXURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:17:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45361EFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:17:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so1774734edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oIjZaVoTVRiYI2EI9MNfmYEqGX+2eYmslPvrV4hb04Y=;
        b=PNmzsJlYLy+1uKOxvOEqIIXYgWt88eDr+EceyU7mtzyAvlN5COX5huKkWnRJM3He38
         SLW8PKiw6XnfBYKZ6DNhjirmDKps4/6eUrx3gFw/GVsGHfzH3B+BLCA2pQ0TWezNZPOv
         spT1BQ0QU4eREUNc1HOHpnJ4apcNtTyrTrOCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIjZaVoTVRiYI2EI9MNfmYEqGX+2eYmslPvrV4hb04Y=;
        b=IpXcPlrckTgZI6S1bNMhu//7+rAH0JdbxjOVDHfqMI4jhisMrmVI5s+fLjzXXo8vlH
         FUsIVlJ5Ids/8BQ0l+2cQIyyVuNQWxoyFV0L7ts+i52FkHy+lshsmY/yvwHfWuXpUysw
         Tth1ruMC+Wul4TZSU2O3TsZ4eJgS5rb5Cc4ivWpYMSchX6AEPOgY66oPeOUyn97We1eH
         hiWV8/20uMESM0pheXSrnvW0bOB2v9D0FjDKPmt+ye2l0n/sLRTE3DZ4Zpii22+eA5vD
         cWPj3/asWUrUaj1Ba9I0OA3gw+ZinctsEGo3sxH4scyHxM6k8gIkfi+o1L758SOrpkcz
         R7tA==
X-Gm-Message-State: AO0yUKXGlB2UPVmPvoe13uABIOnsqznvapN6YoaSJ2/VnQrxTutLIhOj
        Ztm0dugANOUoSSHGlg8OZLOOqDVMCXCtgbC6JJfuLA==
X-Google-Smtp-Source: AK7set9HJWXdQ2c+zaU9UItzT0gIrewOMKoWhms7lhuSaNecNKUfWJFIG/nBy4CyTe52z7Ngzpt8Jg==
X-Received: by 2002:a17:907:206e:b0:8b1:3a8e:232 with SMTP id qp14-20020a170907206e00b008b13a8e0232mr21750012ejb.74.1677269827692;
        Fri, 24 Feb 2023 12:17:07 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id ck20-20020a170906c45400b008c95f0ce32esm7705032ejb.3.2023.02.24.12.17.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 12:17:07 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id ck15so2156424edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:17:06 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr11089353ejc.0.1677269826565; Fri, 24
 Feb 2023 12:17:06 -0800 (PST)
MIME-Version: 1.0
References: <Y/jhwuTCaOgOTLp2@casper.infradead.org> <2134430.1677240738@warthog.procyon.org.uk>
 <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2213409.1677249075@warthog.procyon.org.uk> <2385089.1677258941@warthog.procyon.org.uk>
 <Y/kFnhUM5hjWM2Ae@casper.infradead.org> <2390711.1677269637@warthog.procyon.org.uk>
In-Reply-To: <2390711.1677269637@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 12:16:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpjrdcs_aFvdHdH6TpOsOmN9S5rXDqCZTB8WqXsZH8Qw@mail.gmail.com>
Message-ID: <CAHk-=wgpjrdcs_aFvdHdH6TpOsOmN9S5rXDqCZTB8WqXsZH8Qw@mail.gmail.com>
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:14 PM David Howells <dhowells@redhat.com> wrote:
>
> Then why do we have to wait for PG_writeback to complete?

At least for PG_writeback, it's about "the _previous_ dirty write is
still under way, but - since PG_dirty is set again - the page has been
dirtied since".

So we have to start _another_ writeback, because while the current
writeback *might* have written the updated data, that is not at all
certain or clear.

I'm not sure what the fscache rules are.

                Linus
