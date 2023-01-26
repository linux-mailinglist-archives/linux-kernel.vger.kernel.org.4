Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F567D0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAZQHT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Jan 2023 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjAZQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:07:18 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F6139
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:07:17 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id DF47E1C60F8;
        Thu, 26 Jan 2023 16:07:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 7CC1E80014;
        Thu, 26 Jan 2023 16:07:12 +0000 (UTC)
Message-ID: <3de4cbc2198105bcbc09ee355cd69a8b8756b89c.camel@perches.com>
Subject: Re: git source files with rw permissions
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 26 Jan 2023 08:07:11 -0800
In-Reply-To: <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
References: <1522976022.11185.53.camel@perches.com>
         <CA+55aFw=EQyJv52LjUje8ExMeX99u=8zzPsQAFv2MZ_N4V=Kog@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7CC1E80014
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: wzzqfog8nrdzdxboe1sh8wc7wgf6jjf8
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Ki38cVINSjQ/NcwnFAzSValh6gzhyNeo=
X-HE-Tag: 1674749232-994754
X-HE-Meta: U2FsdGVkX19ShDgeDCzYPTBS0ns4i+UxZtjqvTVn1itfHtvAGY6shSKPKOrr5PfqrtmG/9vjn1cqAWucZx453g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 13:36 -0700, Linus Torvalds wrote:
> On Thu, Apr 5, 2018 at 5:53 PM, Joe Perches <joe@perches.com> wrote:
> > A trivial script on a clean git tree like:
> > 
> > $ git ls-files -- "*.[chsS]" | \
> >   xargs ls -la | \
> >   grep -P "^[^l](?:.{2,2}x|.{5,5}x|.{8,8}x)" | \
> >   awk '{print $9}'
> 
> A simpler version of this is:
> 
>   git ls-files -s '*.[chsS]' | grep '^100755'
> 
> and then you can use 'cut -f2' if you just want the filenames and do
> the "xargs chmod" thing.
> 
> Which I did, and committed, and just pushed out.

Maybe time to do it again.  Current tree:

$ git ls-files -s '*.[chsS]' | grep '^100755' | cut -f2 | xargs chmod 0644
$ git diff --stat -p
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 0
 sound/soc/codecs/es8326.c                 | 0
 sound/soc/codecs/es8326.h                 | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h b/drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
old mode 100755
new mode 100644
diff --git a/sound/soc/codecs/es8326.h b/sound/soc/codecs/es8326.h
old mode 100755
new mode 100644

