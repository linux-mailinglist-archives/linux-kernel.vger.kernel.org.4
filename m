Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABE67572A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjATO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjATO3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:29:31 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895880BB8;
        Fri, 20 Jan 2023 06:29:03 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id D8F497FC21;
        Fri, 20 Jan 2023 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1674224465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/QptElc1Rys5CqmJywuncbTK0Vr1bwZxAuaxjPVSvY=;
        b=hnQ/nuSjgTb0o46XWymkpchmWuQgCLMXxC3J6dEmG7dImpoRMYBpYt2ZSAMp2rlnWP4H4H
        5neXAY8zBU2uoK8yaV284XC5VDDZ+lRNLggbIFbubPYbMl+cif2+3uKGAS/NWYqAsf9Oy3
        Y+1bV1YrA/rRlext+QoRd1gbY5DCjTU7hRzF2yUuv2KW4X2uGqNLKVxva8vJJg/mSw6pY3
        b2OIgENbIYDfMxyG92nQ2sfh60d0J8XyjztRSdBko3LEOoEloL0ETDdoQBXEp7tJrqWyG0
        gWQh+eNUzgnqYRAG7fPve8m1f4ujJX30QHCkbP0cMGOcV18lnVa2QF07uHKX5g==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steve French <stfrench@microsoft.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] cifs: Get rid of unneeded conditional in the
 smb2_get_aead_req()
In-Reply-To: <20230120120857.60444-1-andriy.shevchenko@linux.intel.com>
References: <20230120120857.60444-1-andriy.shevchenko@linux.intel.com>
Date:   Fri, 20 Jan 2023 11:21:01 -0300
Message-ID: <87r0vpe182.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> In the smb2_get_aead_req() the skip variable is used only for
> the very first iteration of the two nested loops, which means
> it's basically in invariant to those loops. Hence, instead of
> using conditional on each iteration, unconditionally assing
> the 'skip' variable before the loops and at the end of the
> inner loop.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  fs/cifs/smb2ops.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
