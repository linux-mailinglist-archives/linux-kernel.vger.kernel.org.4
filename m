Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34B068F103
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBHOk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjBHOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:40:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B58E25E32
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:40:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id be8so19467015plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bxiE2oJ3WnqWoU2J6SBw1NhqrXEZjoU30zxpvXlfoY=;
        b=PD+sjg31omWK6nugbu6srR6lhXG2hugxiw4POwIQV3HMr9rwwpd4Mh5TQTKVkQxQdN
         yYK1lC5mf5HnPQkGNXhZ+Bdt+Hz7GkE7nRennD5gJzqqrEHIIK82e45Ca23ippyhVnLv
         jHJTbx+JoDj/T+V6oJXaBwh06DBVov7TKwo+D6vOUkBXcnYoSxF1ioxWgiLiQeN1tW95
         UPB9kVmw+OgOsL5xlot13IbwMgX+ox6FWO7L090uws91g7ySnJ6ZXzKGM05bUZWf+D+U
         HlRQ3GFI/szrIENIGlDVBbLSmbHA+LEXApxjXITtzX62+Z/3xiiOPoTrgZAofsDY5t3J
         MTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bxiE2oJ3WnqWoU2J6SBw1NhqrXEZjoU30zxpvXlfoY=;
        b=fy4//ohiaCLZLTlSqn8n+o42434Gcs6yjHWg8hMkI1edVqFWAOvX9oFSiBI+K8bVQx
         SCQCbCRTQoc8DuqFXWzQUgUCWrl7QuyW6c9PIEQfDeXs7p2EK6VKLKo/ugMbzbkdjcAQ
         4YKDhp/L+P9NiqCKj94KSCzTaaRB5G4hf4bPg7nG16ShQPY1MPbBoBtqmutatw7t7GdP
         xLOkbqRqC19ULUE+1kG7fea55piTrTU2XgiPvdI1UFDWCMkBceoDoRMJpaMWBIlF/49l
         ditY0EbXl0sVKHXLH+fcEG1tgcAZ5n/1e9aBcW05jzAzsANcxC3/fr6HV912Z96VJbm4
         3LtQ==
X-Gm-Message-State: AO0yUKVjFRSSOZnLUkoVzQ0FjaIfQ9XF3lYv7C7lkyMP8K1qSgpwTC4d
        hRRedZSFUYp72iEl4pbGMZZKXe7IFX+AB+yOr5s=
X-Google-Smtp-Source: AK7set9cnI7ijCR0Pe/LRnHhQyiJoqhpZaqODCYVMDTdmfraExS5wzHGiHkduxKKVSYx4BSModBUCg==
X-Received: by 2002:a17:902:788b:b0:194:6d3c:38a5 with SMTP id q11-20020a170902788b00b001946d3c38a5mr204703pll.1.1675867252646;
        Wed, 08 Feb 2023 06:40:52 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r9-20020a63a009000000b004db2b310f95sm9689139pge.16.2023.02.08.06.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:40:52 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:40:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] KVM: selftests: Make reclaim_period_ms input always
 be positive
Message-ID: <Y+O0cGu0lgg+mDJr@google.com>
References: <20230111183408.104491-1-vipinsh@google.com>
 <167582135970.455074.533102478332510041.b4-ty@google.com>
 <CAHVum0e0ZL-Q7DwZ-SYSuqX1n_9EU85mYhyvUA=75zpJ6a29ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0e0ZL-Q7DwZ-SYSuqX1n_9EU85mYhyvUA=75zpJ6a29ow@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023, Vipin Sharma wrote:
> On Tue, Feb 7, 2023 at 6:10 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, 11 Jan 2023 10:34:08 -0800, Vipin Sharma wrote:
> > > reclaim_period_ms use to be positive only but the commit 0001725d0f9b
> > > ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> > > validation") incorrectly changed it to non-negative validation.
> > >
> > > Change validation to allow only positive input.
> > >
> > >
> > > [...]
> >
> > Applied to kvm-x86 selftests, thanks!
> 
> Just FYI, this patch has already been applied to kvm/master branch.
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=c2c46b10d52624376322b01654095a84611c7e09

Now I know why I was getting deja vu...  Dropped, thanks Vipin!
