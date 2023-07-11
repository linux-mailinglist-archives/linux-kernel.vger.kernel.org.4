Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79874F885
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGKTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKTqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:46:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F51730
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 164A3615E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44295C433C8;
        Tue, 11 Jul 2023 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689104790;
        bh=oagomkcQa/oXl5+aZDOLNoxvsSWXn4ATh/auNAuthDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUPyaibc8L/ggTxuNzTCY2ikAuY9Q0sDupvAnGogZgYxtNvM9vRGxb4GrfKTWpcpF
         B1h3lMl4eqljM9aFBuu8S2MIXfeNyfBjtoGltF7CpwbrMY4WVu6NpLZgommVJ0COgR
         TtfHwyQC1D2dGfBRvrR4PrYi/5hxViaR3gZEa2EmV+6ivIYqR4TUGVx3Nk7tB9Og+b
         ALtepbWoO58Refl9daZqp7toMUGkVMIQTf3skzQpw1cmrI6JeDVgKM/gYbFQBKTR5G
         DTDL4lC7wwCZ27wR7TpZai1UBVG2JPepcQbJh6vzsw3qr8fzf0iR+hgFqaB/wq6os4
         /0Jx0sy/RNOKw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7ED9140516; Tue, 11 Jul 2023 16:46:27 -0300 (-03)
Date:   Tue, 11 Jul 2023 16:46:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib subcmd: Avoid segv/use-after-free when commands
 aren't excluded
Message-ID: <ZK2xk2qJE2M+bGCb@kernel.org>
References: <20230707230926.841086-1-irogers@google.com>
 <CAM9d7chqAkLuYYyOSM5n1S-Rzf5ivCCuaqz5Tc1j23a2NsWzFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chqAkLuYYyOSM5n1S-Rzf5ivCCuaqz5Tc1j23a2NsWzFQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 11, 2023 at 10:36:59AM -0700, Namhyung Kim escreveu:
> On Fri, Jul 7, 2023 at 4:09 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The array shortening may perform unnecessary array copies. Before
> > commit 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> > this was benign, but afterwards this could lead to a segv.
> >
> > Fixes: 657a3efee43a ("lib subcmd: Avoid memory leak in exclude_cmds")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/lib/subcmd/help.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> > index 67a8d6b740ea..adfbae27dc36 100644
> > --- a/tools/lib/subcmd/help.c
> > +++ b/tools/lib/subcmd/help.c
> > @@ -68,8 +68,13 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
> >         while (ci < cmds->cnt && ei < excludes->cnt) {
> >                 cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
> >                 if (cmp < 0) {
> > -                       zfree(&cmds->names[cj]);
> > -                       cmds->names[cj++] = cmds->names[ci++];
> > +                       if (ci == cj) {
> > +                               ci++;
> > +                               cj++;
> > +                       } else {
> > +                               zfree(&cmds->names[cj]);
> > +                               cmds->names[cj++] = cmds->names[ci++];
> > +                       }
> >                 } else if (cmp == 0) {
> >                         ci++;
> >                         ei++;
> > @@ -77,10 +82,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
> >                         ei++;
> >                 }
> >         }
> > -
> > -       while (ci < cmds->cnt) {
> > -               zfree(&cmds->names[cj]);
> > -               cmds->names[cj++] = cmds->names[ci++];
> > +       if (ci != cj) {
> > +               while (ci < cmds->cnt) {
> > +                       zfree(&cmds->names[cj]);
> > +                       cmds->names[cj++] = cmds->names[ci++];
> > +               }
> >         }
> >         for (ci = cj; ci < cmds->cnt; ci++)
> >                 zfree(&cmds->names[ci]);
> > --
> > 2.41.0.390.g38632f3daf-goog
> >

-- 

- Arnaldo
