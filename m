Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46D06F9D63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjEHBaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEHBaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D765FC3
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683509367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQFLJyFxQe/WmXiJ0plNddWag3eZBQCk8VARawBfOrk=;
        b=S28JkUSOzdvFzOsAoYDplT/dwHpYXcp1KG245+pirUKlAyqvYZ4TpurD2NYB9PmKSBXa4z
        ghrbzWpSgb5A2UeYeN81wfxZi6RQERHcfFO1DuEgPp8y4uJvKQeOw96JI3Fznuff/Z7X1Z
        ANSECtaJIxsBv7v3uzPIH6bNZRmZrzk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-d4lnVFC_MximwZGCTZfUXA-1; Sun, 07 May 2023 21:29:26 -0400
X-MC-Unique: d4lnVFC_MximwZGCTZfUXA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6442745be9bso419284b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 18:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683509365; x=1686101365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQFLJyFxQe/WmXiJ0plNddWag3eZBQCk8VARawBfOrk=;
        b=U+sTDrs4FbnZs7xsmIWW61YyhBSWZHCtPDJEdAoojFwPf+sEN/xPOr13yDijnS8PmE
         UKXMV3OxUynQyJIxFB6fuQDv0SoKvGOITStYT6s3AjEIhw+n9uflPBZk+SKiVIDHISIU
         Jo5gEewpYyTUXp8SquRcv6bA+XBWbhOZWt4X1Kdej/EoPM45VSMmpupyvWp4R8ox5bzP
         4i5x7C45Oax2lJwh4F8c5Z0W17RvqJ3lRfrApbMFEzI4D/wLOyfdkBLJHdvLPyR1yvxG
         zZXEzlS9JlKrxACShAJGjCRFZXYf5cFXxk8G75cO+hD05tAiuzQfXqQFLYBB7q+9ki2b
         eTbw==
X-Gm-Message-State: AC+VfDxNpRDz1xIZegeV32NK8PoFaq6iDY9kDO/5pDTjiG7ZoFqbaRY2
        s4IvbWKfIOBO8Rbb6lnp2FBEL8t9hU+ZAYw17Q+ZOGn4qdRNayAThjkypUXF3gQP11Ua62xtgjx
        FJcyGzbQS8QuzMMG7NOb75QI+
X-Received: by 2002:a17:902:db0a:b0:19a:a815:2877 with SMTP id m10-20020a170902db0a00b0019aa8152877mr10591246plx.6.1683509365104;
        Sun, 07 May 2023 18:29:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ynB3ZV1UTQiGDzxNyvKwQ+Ch2kNH77iV4wRFTKDoxgblCq6adzXcf16CYkbTEHVwKWxrbBQ==
X-Received: by 2002:a17:902:db0a:b0:19a:a815:2877 with SMTP id m10-20020a170902db0a00b0019aa8152877mr10591227plx.6.1683509364792;
        Sun, 07 May 2023 18:29:24 -0700 (PDT)
Received: from x1n ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709028f8e00b001aaf6353736sm5785489plo.80.2023.05.07.18.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 18:29:23 -0700 (PDT)
Date:   Sun, 7 May 2023 21:29:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Subject: Re: [PATCH 0/4] MDWE without inheritance
Message-ID: <ZFhQcwDBFWcRCC4N@x1n>
References: <20230504170942.822147-1-revest@chromium.org>
 <ZFQQSKijXQHWlYaI@x1n>
 <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 06:42:08PM +0200, Florent Revest wrote:
> On Thu, May 4, 2023 at 10:06 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, May 04, 2023 at 07:09:38PM +0200, Florent Revest wrote:
> > > Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl which tags
> > > current with a flag that prevents pages that were previously not executable from
> > > becoming executable.
> > > This tag always gets inherited by children tasks. (it's in MMF_INIT_MASK)
> > >
> > > At Google, we've been using a somewhat similar downstream patch for a few years
> > > now. To make the adoption of this feature easier, we've had it support a mode in
> > > which the W^X flag does not propagate to children. For example, this is handy if
> > > a C process which wants W^X protection suspects it could start children
> > > processes that would use a JIT.
> > >
> > > I'd like to align our features with the upstream prctl. This series proposes a
> > > new NO_INHERIT flag to the MDWE prctl to make this kind of adoption easier. It
> > > sets a different flag in current that is not in MMF_INIT_MASK and which does not
> > > propagate.
> >
> > I don't think I have enough context, so sorry if I'm going to ask a naive
> > question..
> 
> Not at all! :) You're absolutely right, it's important to address these points.
> 
> > I can understand how current MDWE helps on not allowing any modifi-able
> > content from becoming executable.  How could NO_INHERIT help if it won't
> > inherit and not in MMF_INIT_MASK?
> 
> The way I see it, enabling MDWE is just a small step towards hardening
> a binary anyway. It can possibly make exploitation a bit harder in the
> case where the attacker has _just_: a write primitive they can use to
> write a shellcode somewhere and a primitive to make that page
> executable later. It's a fairly narrow protection already and I think
> it only really helps as part of a broader "defense in depth" strategy.
> 
> > IIUC it means the restriction will only apply to the current process.  Then
> > I assume the process can escape from this rule simply by a fork().  If so,
> > what's the point to protect at all?
> 
> If we assume enough control from the attacker, then MDWE is already
> useless since it can be bypassed by writing to a file and then
> mmapping that file with PROT_EXEC. I think that's a good example of
> how "perfect can be the enemy of good" in security hardening. MDWE
> isn't a silver-bullet but it's a cheap trick and it makes a small dent
> in reducing the attack surface so it seems worth having anyway ?
> 
> But indeed, to address your question, if you choose to use this
> NO_INHERIT flag: you're no longer protected if the attacker can fork()
> as part of their exploitation. I think it's been a useful trade-off
> for our internal users since, on the other hand, it also makes
> adoption a lot easier: our C++ services developers can trivially opt
> into a potpourri of hardening features without having to think too
> much about how they work under-the-hood. The default behavior has been
> to use a NO_INHERIT strategy so users don't get bad surprises the day
> when they try to spawn a JITted subcommand. In the meantime, their C++
> service still gets a little bit of extra protection.
> 
> > And, what's the difference of this comparing to disabling MDWE after being
> > enabled (which seems to be forbidden for now, but it seems fork() can play
> > a similar role of disabling it)?
> 
> That would be functionally somewhat similar, yes. I think it mostly
> comes down to ease of adoption. I imagine that users who would opt
> into NO_INHERIT are those who are interested in MDWE for the binary
> they are writing but aren't 100% confident in what subprocesses they
> will run and so they don't have to think about disabling it after
> every fork.

Okay, that makes sense to me.  Thanks.

Since the original MDWE was for systemd, I'm wondering what will happen if
some program like what you said is invoked by systemd and with MDWE enabled
already.

Currently in your patch IIUC MDWE_NO_INHERIT will fail directly on MDWE
enabled process, but then it makes me think whether it makes more sense to
allow converting MDWE->MDWE_NO_INHERIT in this case.  It seems to provide a
most broad coverage on system daemons using MDWE starting from systemd
initial process, meanwhile allows specific daemons to fork into anything
like a JIT process so it can make itself NO_INHERIT.  Attackers won't
leverage this because MDWE_NO_INHERIT also means MDWE enabled.

-- 
Peter Xu

