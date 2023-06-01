Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A337471978C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjFAJql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjFAJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E163185;
        Thu,  1 Jun 2023 02:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E0F642A2;
        Thu,  1 Jun 2023 09:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B577C433EF;
        Thu,  1 Jun 2023 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685612780;
        bh=Gg96iZLMK8kzUxxht+t3UCZqIJdqGyKJzoxElzCHMTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G41V2nFtvaFiwye0ois2vOYZ7ldqNDE+p9UzFe0Yk5SdBPDyZTZmJ4y7DYc/ijJUR
         4OWaxzb1EsWig0l391kuS0m1m5i+kJ4lb2uO2YE1qE1znilIS1Iucyvs34i8H5NGOk
         bZQRNxOPiwPopXLjSUsXh/Mtf7IrBB87RkWsjll1uHeXcT+5F5BmVTwCBDBTDhR/MP
         KXK/LC9VvseIWD6nAmkcof7+j+CrvBH1UGzjnh5b3/WVnHrGOV4xuz9SK6eQTlCpT3
         no61vbYDc29I07HzzxUqml0X76CbqGSH3yCJl0yC+x5RvKqM2rtapFx4twx0u/j4t5
         AagXuirb/O0SA==
Date:   Thu, 1 Jun 2023 11:46:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home>
 <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain>
 <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:10:47PM -0700, Alexei Starovoitov wrote:
> On Wed, May 17, 2023 at 9:50 AM Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > >
> > > >
> > > > Looks like user events were designed with intention to be unprivileged.
> > > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > > I doubt other people reviewed it from security perspective.
> > > >
> > > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" doesn't sound like a good idea.
> > > >
> > > > For example, I think the following is possible:
> > > > fd = open("/sys/kernel/tracing/user_events_data")
> > > > ioclt(fd, DIAG_IOCSDEL)
> > > >   user_events_ioctl_del
> > > >      delete_user_event(info->group, name);
> > > >
> > > > 'info' is different for every FD, but info->group is the same for all users/processes/fds,
> > > > because only one global init_group is created.
> > > > So one user can unregister other user event by knowing 'name'.
> > > > A security hole, no?
> 
> ...
> 
> > Regarding deleting events, only users that are given access can delete
> > events. They must know the event name, just like users with access to
> > delete files must know a path (and have access to it). Since the
> > write_index and other details are per-process, unless the user has
> > access to either /sys/kernel/tracing/events/user_events/* or
> > /sys/kernel/tracing/user_events_status, they do not know which names are
> > being used.
> >
> > If that is not enough, we could require CAP_SYSADMIN to be able to
> > delete events even when they have access to the file. Users can also
> > apply SELinux policies per-file to achieve further isolation, if
> > required.
> 
> Whether /sys/kernel/tracing/user_events_status gets g+rw
> or it gets a+rw (as your documentation recommends)
> it is still a security issue.
> The "event name" is trivial to find out by looking at the source code
> of the target process or just "string target_binary".
> Restricting to cap_sysadmin is not the answer, since you want unpriv.
> SElinux is not the answer either.
> Since it's unpriv, different processes should not be able to mess with
> user events of other processes.
> It's a fundamental requirement of any kernel api.
> This has to be fixed before any bpf discussion.
> If it means that you need to redesign user_events do it now and
> excuses like "it's uapi now, so we cannot fix it" are not going to fly.

Looking at this a little because I have a few minutes.
What's all this unused code?

static inline struct user_event_group
*user_event_group_from_user_ns(struct user_namespace *user_ns)
{
        if (user_ns == &init_user_ns)
                return init_group;

        return NULL;
}

static struct user_event_group *current_user_event_group(void)
{
        struct user_namespace *user_ns = current_user_ns();
        struct user_event_group *group = NULL;

        while (user_ns) {
                group = user_event_group_from_user_ns(user_ns);

                if (group)
                        break;

                user_ns = user_ns->parent;
        }

        return group;
}

User namespaces form strict hierarchies so you always end up at
init_user_ns no matter where you start from in the hierarchy. Return the
init_group and delete that code above.

static char *user_event_group_system_name(struct user_namespace *user_ns)
{
        char *system_name;
        int len = sizeof(USER_EVENTS_SYSTEM) + 1;

        if (user_ns != &init_user_ns) {
                /*
                 * Unexpected at this point:
                 * We only currently support init_user_ns.
                 * When we enable more, this will trigger a failure so log.
                 */
                pr_warn("user_events: Namespace other than init_user_ns!\n");
                return NULL;
        }

Your delegation model is premised on file permissions of a single file
in global tracefs. It won't work with user namespaces so let's not give
the false impression that this is on the table.

Plus, all of this is also called in a single place during
trace_events_user_init() which is called from fs_initcall() so you
couldn't even pass a different user namespace if you wanted to because
only init_user_ns exists.
