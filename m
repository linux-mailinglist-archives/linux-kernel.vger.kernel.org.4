Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E355FA6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJJVCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJJVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4034DF26
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665435643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4uD7PcusRTs1FmNqEf5EidHCGLTkvzFZqNuu04jz9s=;
        b=etKiY0BUPDPBp1QSuHj+toqOXsvwAcekiC0GvxKvsIlUB8vBAoVn6w1/b73G/cHiOUh1UF
        1IPLfYoLs6frEJOmZCiiCqU42tGytDeSvK7X2134vV2GqmhSII6pLbkbofbm3xYox0KWf+
        kDWO3bdxbByTFq5vjeOQFu/5Pqs0ezM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-JzEKtavvPtOL9Rt8hNQR7A-1; Mon, 10 Oct 2022 17:00:42 -0400
X-MC-Unique: JzEKtavvPtOL9Rt8hNQR7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99936802C17;
        Mon, 10 Oct 2022 21:00:41 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 444F0215688F;
        Mon, 10 Oct 2022 21:00:41 +0000 (UTC)
Date:   Mon, 10 Oct 2022 16:00:39 -0500
From:   David Teigland <teigland@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <20221010210039.GA30273@redhat.com>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
 <202210082044.51106145BD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210082044.51106145BD@keescook>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:03:28PM -0700, Kees Cook wrote:
> On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> > On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> > 
> > That's true. I agree that leaving "+ 1" would work and produce a
> > no-binary-changes patch due to the existing padding that the structure
> > has. OTOH, I thought that relying on that space could bite us in the
> > future if anyone tweaks the struct again...so my reaction was to ensure 
> > that the NUL-terminator space was always guaranteed to be there.
> > Hence, the change on c693 (objdump above).
> > 
> > What do you think? Should we keep or leave the above
> > "+ 1" after the rationale above?
> 
> I think it depends on what's expected from this allocation. Christine or
> David, can you speak to this?

Hi, thanks for picking through that.  Most likely the intention was to
allow up to 64 (DLM_LOCKSPACE_LEN) character names, and then use the
ls_name[1] for the terminating byte.  I'd be happy to take the patch
replacing the one-element name.  Or, if you'd like to drop it, then we'll
eliminate it along with a cleanup of name/namelen more broadly.

Dave

