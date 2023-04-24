Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84F6EC7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDXIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjDXIKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:10:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F00E58
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F7861265
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE2FC433EF;
        Mon, 24 Apr 2023 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682323831;
        bh=yuhc7dyZM5udx3a4xN75Z1cqoTpgyOnSoTcZeWOAnes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaxQPxcDWg1c8JHKHYNt130+r9ASw65dFAxtQf0LOqn5oxzHEGeXzNWt7+Vasds+2
         z+/fU68ViORlxgOXuMt58p1ed6USiUfftN9V5+HestEB62JVLfowNYPB2thJEDg4dW
         QUPH/pw3RR9KSeogrbHVRRZ9nPwLLC15/FQ/weBJSRFnGe/I6VHArzMC6vODMLZ5V0
         M5PMtEtsxAAJR15IM/l+cUlY7HRFc4QBuqSjFmG/3TCo+WAwal/bLh+y5oUurVadDZ
         940PKQqP5d/GM2OpFKx50hUTclFUMxUGEZVRkOnXE5JuY9eTPohE9mJwuNk4RzeOyI
         4rpsN6NScNKrA==
Date:   Mon, 24 Apr 2023 10:10:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>,
        akpm <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230424-unser-erden-693a29d7a388@brauner>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
 <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
 <20230420204801.GO3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420204801.GO3390869@ZenIV>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:48:01PM +0100, Al Viro wrote:
> On Tue, Apr 18, 2023 at 02:56:38PM +0200, Christian Brauner wrote:
> > On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> > > Andrew picked ocfs2 patches into -mm tree before.
> > 
> > Yup and that's fine obviously, but this belongs to fs/ and we're aiming
> > to take fs/ stuff through the dedicated fs trees going forward.
> 
> Er...  Assuming that there *is* an active fs tree for filesystem
> in question.  Do you really want dedicated e.g. affs, adfs, etc.
> git trees - one for each filesystem in there?

No, that's not meant or want. What I meant is that when a filesystem
doesn't have a dedicated tree (and/or active maintainers) mentioned in
the maintainer's file then we pick up those patches just like we already
do today and have done.
