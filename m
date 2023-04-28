Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A06F2051
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjD1V6J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1V6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:58:06 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA640CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:58:05 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 1E2D2160362;
        Fri, 28 Apr 2023 21:58:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 433E720024;
        Fri, 28 Apr 2023 21:58:02 +0000 (UTC)
Message-ID: <2a0436c3a3e5345de70f7ba1067afb2a0475e63f.camel@perches.com>
Subject: Re: get_maintainer.pl wrong and undeterministic? (was: Re: [PATCH
 v2 2/2] usb: gadget: udc: Handle gadget_connect failure during bind
 operation)
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Apr 2023 14:58:00 -0700
In-Reply-To: <CAMuHMdW4whkqdj+CXbSbnJK+hA+ePf81O_1gh+VP-saY6-e=HQ@mail.gmail.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
         <20230328160756.30520-3-quic_kriskura@quicinc.com>
         <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
         <CAMuHMdXdP6fPPQxvAdQCz2P_SPnCLjEpqiTHerF05e7tJmWHFg@mail.gmail.com>
         <2070d2fc-9bdc-57f8-d789-4fa6412fc7ed@quicinc.com>
         <CAMuHMdUKqo6paF5efFVr0tmA3mpOAraZORoKyVFi8Pkt=H4z6Q@mail.gmail.com>
         <592c2095-a6dc-de4b-713d-a9a582f966e0@quicinc.com>
         <CAMuHMdW4whkqdj+CXbSbnJK+hA+ePf81O_1gh+VP-saY6-e=HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 433E720024
X-Stat-Signature: tg4gzi8z5dnrfopirtcnyee7cp1upe7t
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+sTBP9OM4+l0bjgJPwA2018H7KiqBaR6E=
X-HE-Tag: 1682719082-400789
X-HE-Meta: U2FsdGVkX18cCEIFGFWvtlSmwtRfYN1a5Bv05E9vRR8hM4mqOQKf4f2qU18Su1my4lvjtDR6NfyvPPf39x1d6g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-27 at 11:09 +0200, Geert Uytterhoeven wrote:
> Hi Krishna,
> 
> CC Joe and lkml

get_maintainer is sometimes non deterministic.

When adding maintainers from git commit logs (and btw, it's
not just nominal maintainers, it's any signers), if the
same number of signature names are read from the commit logs
the selection of the listed entries _is_ random.

see: https://lore.kernel.org/lkml/1499984554.4457.64.camel@perches.com/

> 
> On Thu, Apr 27, 2023 at 10:44 AM Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
> > On 4/27/2023 1:23 PM, Geert Uytterhoeven wrote:
> > > On Thu, Apr 27, 2023 at 5:49 AM Krishna Kurapati PSSNV
> > > <quic_kriskura@quicinc.com> wrote:
> > > > On 4/26/2023 2:48 PM, Geert Uytterhoeven wrote:
> > > > > On Wed, Apr 26, 2023 at 3:17 AM Krishna Kurapati PSSNV to l
> > > > > <quic_kriskura@quicinc.com> wrote:
> > > > > > Hi Alan, Geert,
> > > > > > 
> > > > > >     Can you help review and provide comments/approval on the following patch.
> > > > > 
> > > > > I don't know why you are addressing me, as I never touched the affected
> > > > > file, am not listed as its maintainer, and don't know much about USB UDC.
> > > 
> > > >    Apologies. I must have caused some confusion because of same name. I
> > > > must have specified clearly whom I was referring to.
> > > > 
> > > > I CC'd and was referring to Geert Uytterhoeven <geert+renesas@glider.be>
> > > > for comments.
> > > 
> > > That's actually me, too ;-)
> > > 
> > > > As per the output of get_maintainer.pl
> > > > 
> > > > ./scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
> > > > 
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
> > > > SUBSYSTEM,commit_signer:6/6=100%,authored:1/6=17%,removed_lines:2/26=8%)
> > > > Alan Stern <stern@rowland.harvard.edu>
> > > > (commit_signer:4/6=67%,authored:3/6=50%,added_lines:36/45=80%,removed_lines:17/26=65%)
> > > > TaoXue <xuetao09@huawei.com> (commit_signer:1/6=17%)
> > > > "Rafael J. Wysocki" <rafael@kernel.org> (commit_signer:1/6=17%)
> > > > Geert Uytterhoeven <geert+renesas@glider.be> (commit_signer:1/6=17%)
> > > > Colin Ian King <colin.i.king@gmail.com> (authored:1/6=17%)
> > > > Jiantao Zhang <water.zhangjiantao@huawei.com>
> > > > (authored:1/6=17%,added_lines:6/45=13%,removed_lines:6/26=23%)
> > > 
> > > Interesting, I don't see me listed when running that command (on v6.3 and
> > > next-20230425), and I never authored any change to that file.
> > > What is the tree (commit sha1) you are running ./scripts/get_maintainer.pl on?
> > 
> > I checked it on linux-next a couple of weeks back and it showed me this.
> > But when I synced latest linux kernel, it didn't show it today 😅
> > Not sure, what is the diff here.
> 
> Interesting:
> 
>     $ git checkout next-20230425
>     Updating files: 100% (7386/7386), done.
>     Previous HEAD position was 198925fae644b009 Add linux-next
> specific files for 20230329
>     HEAD is now at f600e0bbde8562a0 Add linux-next specific files for 20230425
>     $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
>     Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
> SUBSYSTEM,commit_signer:11/11=100%,authored:3/11=27%,removed_lines:5/73=7%)
>     Alan Stern <stern@rowland.harvard.edu>
> (commit_signer:4/11=36%,authored:3/11=27%,added_lines:36/182=20%,removed_lines:17/73=23%)
>     Badhri Jagan Sridharan <badhri@google.com>
> (commit_signer:2/11=18%,authored:2/11=18%,added_lines:107/182=59%,removed_lines:44/73=60%)
>     Elson Roy Serrao <quic_eserrao@quicinc.com>
> (commit_signer:1/11=9%,added_lines:27/182=15%)
>     Sebastian Reichel <sre@kernel.org> (commit_signer:1/11=9%)
>     Colin Ian King <colin.i.king@gmail.com> (authored:1/11=9%)
>     Jiantao Zhang <water.zhangjiantao@huawei.com>
> (authored:1/11=9%,removed_lines:6/73=8%)
>     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
>     linux-kernel@vger.kernel.org (open list)
>     $ git checkout next-20230329
>     Updating files: 100% (7386/7386), done.
>     Previous HEAD position was f600e0bbde8562a0 Add linux-next
> specific files for 20230425
>     HEAD is now at 198925fae644b009 Add linux-next specific files for 20230329
>     $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
>     Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
> SUBSYSTEM,commit_signer:8/8=100%,authored:3/8=38%,added_lines:5/48=10%,removed_lines:5/29=17%)
>     Alan Stern <stern@rowland.harvard.edu>
> (commit_signer:3/8=50%,authored:3/8=38%,added_lines:36/48=75%,removed_lines:17/29=59%)
>     Geert Uytterhoeven <geert+renesas@glider.be> (commit_signer:1/8=12%)
>     Sebastian Reichel <sre@kernel.org> (commit_signer:1/8=12%)
>     Heikki Krogerus <heikki.krogerus@linux.intel.com> (commit_signer:1/8=12%)
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> I, Sebastian, and Heikki never touched this file...
> 
>      Jiantao Zhang <water.zhangjiantao@huawei.com>
> (authored:1/8=12%,added_lines:6/48=12%,removed_lines:6/29=21%)
>     Colin Ian King <colin.i.king@gmail.com> (authored:1/8=12%)
>     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
>     linux-kernel@vger.kernel.org (open list)
>     $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
>     Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
> SUBSYSTEM,commit_signer:8/8=100%,authored:3/8=38%,added_lines:5/48=10%,removed_lines:5/29=17%)
>     Alan Stern <stern@rowland.harvard.edu>
> (commit_signer:4/8=50%,authored:3/8=38%,added_lines:36/48=75%,removed_lines:17/29=59%)
>     "Rafael J. Wysocki" <rafael@kernel.org> (commit_signer:1/8=12%)
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Heikki and I are gone, but Rafael is new and also hasn't touched this file?
> 
>     Colin Ian King <colin.i.king@gmail.com>
> (commit_signer:1/8=12%,authored:1/8=12%)
>     Sebastian Reichel <sre@kernel.org> (commit_signer:1/8=12%)
>     Jiantao Zhang <water.zhangjiantao@huawei.com>
> (authored:1/8=12%,added_lines:6/48=12%,removed_lines:6/29=21%)
>     linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
>     linux-kernel@vger.kernel.org (open list)
> 
> You can see the differences when running the following multiple times:
> 
>     $ diff <(scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c)
> <(scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c)
> 
> Looks like scripts/get_maintainer.pl (a) shows wrong committers (they
> did provide other e.g. Reviewed-by tags), and (b) is not deterministic?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

