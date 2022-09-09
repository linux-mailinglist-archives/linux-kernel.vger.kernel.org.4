Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321605B40F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIIUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiIIUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:44:55 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60161F61F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:44:51 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id i1so2916938vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vNti+T8KdfeUbPCsgvNipWCAd23AlZaiYSX0mU/iJEY=;
        b=e/+fJVZriw6O2R662XaZhAb7hINqQY3Bcv0IJ/NrypmS5hxFIG1BfkNkva1t9FOGV1
         BoIs36Zmo/2s6IlJBQKBFDseUYifKGnKUvP5YBtfbuvQZHLimB92szWtoKQ5ik/556Rz
         5zkYgyXf2Wao95z3LvxFoAhjYt/K3jGajgqzFxFAkziwZi2/khe8ng6YyCzvmOayeOux
         H8GzioC1IDENqDnOU+Cz+s5CGJLh4YgLTx1e6i9/WEPbt/Cz5vTwwSkapkFWd3JtATKq
         avOdZmeR32ZvXMQVoISu5/6EdghhgTWIRJx6QGx5fhoLAbv7p/bvJYBpAbOyDhPlscLu
         Ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vNti+T8KdfeUbPCsgvNipWCAd23AlZaiYSX0mU/iJEY=;
        b=FTAdQrFx1nx4fiMH0HqsJHAyNribXCMk+1VUs03cRIpqvSxfhncooWh1L5dFiAQ+Rl
         Sh4P2XDjPYzPnevr9+iZY24GewuxEPRgU1bkDgebMHT8i95i+ntMcBN8/9FIPXhVwTbY
         pbAIZApeB4X8yxQNWu4KBXkvH8BkNF9xcM9zckNNqegHDbvJbvBlXM8BZHUt6g0gokqZ
         xCFKxrHhU1sRzY4Qj0oq7RSXFcqLCeLhb/I8jel8TcdrSTG3+SH3imEFy3GpeIVtfqEO
         qGETkfPVw0vqQG8NO7BGKw43lYdIe3K2WgZ9XHj28sKpZ7TvJQRGCxFtpVnWQWplcUZL
         16Qg==
X-Gm-Message-State: ACgBeo0bEq8zTW1zAtfXFtxWmfL+YpbIfW5w7c3sKKiRHGM72dk3iQgE
        8YJqSw4ZU3cRPWxoEeoPN6NQRXqMCXb707xYznk=
X-Google-Smtp-Source: AA6agR7KWk+cWS4XN1yruX0hsk3H+o6x1VgWSHBVGtpUP44GHpQKTBK4PDhhVF+zwznL5K77mxpnW6ZZxQeQLnh4ZAQ=
X-Received: by 2002:a05:6102:3a4c:b0:398:3098:a301 with SMTP id
 c12-20020a0561023a4c00b003983098a301mr3964922vsu.74.1662756289685; Fri, 09
 Sep 2022 13:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220904214134.408619-1-jim.cromie@gmail.com> <20220904214134.408619-18-jim.cromie@gmail.com>
 <2d3846cb-ff9a-3484-61a8-973799727d8f@akamai.com>
In-Reply-To: <2d3846cb-ff9a-3484-61a8-973799727d8f@akamai.com>
From:   jim.cromie@gmail.com
Date:   Fri, 9 Sep 2022 14:44:23 -0600
Message-ID: <CAJfuBxzM=KKPbcks-aQLAJM0QVd5sjL-CucYbyFbeG5sgoCVjg@mail.gmail.com>
Subject: Re: [PATCH v6 17/57] dyndbg: validate class FOO by checking with module
To:     Jason Baron <jbaron@akamai.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, robdclark@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 12:19 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 9/4/22 17:40, Jim Cromie wrote:
> > Add module-to-class validation:
> >
> >   #> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control
> >
> > If a query has "class FOO", then ddebug_find_valid_class(), called
> > from ddebug_change(), requires that FOO is known to module X,
> > otherwize the query is skipped entirely for X.  This protects each
> > module's class-space, other than the default:31.
> >
> > The authors' choice of FOO is highly selective, giving isolation
> > and/or coordinated sharing of FOOs.  For example, only DRM modules
> > should know and respond to DRM_UT_KMS.
> >
> > So this, combined with module's opt-in declaration of known classes,
> > effectively privatizes the .class_id space for each module (or
> > coordinated set of modules).
> >
> > Notes:
> >
> > For all "class FOO" queries, ddebug_find_valid_class() is called, it
> > returns the map matching the query, and sets valid_class via an
> > *outvar).
> >
> > If no "class FOO" is supplied, valid_class = _CLASS_DFLT.  This
> > insures that legacy queries do not trample on new class'd callsites,
> > as they get added.
>
>
> Hi Jim,
>
> I'm wondering about the case where we have a callsite which is marked
> as 'class foo', but the query string is done by say module and file, so:
>
> # echo "module bar file foo.c +p" > /proc/dynamic_debug_control
>
> With the proposed code, I think this ends up not enabling anything right?

correct - the only way to enable :    pr_debug_cls(CL_FOO, " ...")
is
   echo class CL_FOO +p > control

1st, existing dyndbg query uses, whether ad-hoc or scripted,
were not written in anticipation of new / classified subsystems.

2nd, new class users dont want to sit in coach. no damn legroom.

3rd, consider DRM, which already has drm.debug
ie:  /sys/module/drm/parameters/debug
and prefers it, at least by inertia.
protecting these new class'd callsites (3-5k of them)
from casual (unintended) manipulations of the kernel-wide
dyndbg state seems prudent, and a usability win.

Not everyone will use module bar, requiring "class foo"
guarantees that changes are intentional.



> Because valid class is set to _DPRINTK_CLASS_DFLT and then:
> 'dp->class_id != valid_class' is true?
>
> This seems confusing to me as a user as this doesn't work like the
> other queries....so maybe we should only do the
> 'dp->class_id != valid_class' check *if* query->class_string is set,
> see below.
>

Could you clarify whether you think this is a logic error
or a frame-of-reference difference as elaborated above ?

ISTM theres a place for a well-worded paragraph in doc
about the class distinction, perhaps a whole for-authors section.



>
>
> >
> > Also add a new column to control-file output, displaying non-default
> > class-name (when found) or the "unknown _id:", if it has not been
> > (correctly) declared with one of the declarator macros.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  lib/dynamic_debug.c | 76 ++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 68 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index b71efd0b491d..db96ded78c3f 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -56,6 +56,7 @@ struct ddebug_query {
> >       const char *module;
> >       const char *function;
> >       const char *format;
> > +     const char *class_string;
> >       unsigned int first_lineno, last_lineno;
> >  };
> >
> > @@ -136,15 +137,33 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
> >                       fmtlen--;
> >       }
> >
> > -     v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
> > -              msg,
> > -              query->function ?: "",
> > -              query->filename ?: "",
> > -              query->module ?: "",
> > -              fmtlen, query->format ?: "",
> > -              query->first_lineno, query->last_lineno);
> > +     v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s\n",
> > +               msg,
> > +               query->function ?: "",
> > +               query->filename ?: "",
> > +               query->module ?: "",
> > +               fmtlen, query->format ?: "",
> > +               query->first_lineno, query->last_lineno, query->class_string);
> >  }
> >
> > +static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
> > +                                                       const char *class_string, int *class_id)
> > +{
> > +     struct ddebug_class_map *map;
> > +     int idx;
> > +
> > +     list_for_each_entry(map, &dt->maps, link) {
> > +             idx = match_string(map->class_names, map->length, class_string);
> > +             if (idx >= 0) {
> > +                     *class_id = idx + map->base;
> > +                     return map;
> > +             }
> > +     }
> > +     *class_id = -ENOENT;
> > +     return NULL;
> > +}
> > +
> > +#define __outvar /* filled by callee */
> >  /*
> >   * Search the tables for _ddebug's which match the given `query' and
> >   * apply the `flags' and `mask' to them.  Returns number of matching
> > @@ -159,6 +178,8 @@ static int ddebug_change(const struct ddebug_query *query,
> >       unsigned int newflags;
> >       unsigned int nfound = 0;
> >       struct flagsbuf fbuf, nbuf;
> > +     struct ddebug_class_map *map = NULL;
> > +     int __outvar valid_class;
> >
> >       /* search for matching ddebugs */
> >       mutex_lock(&ddebug_lock);
> > @@ -169,9 +190,22 @@ static int ddebug_change(const struct ddebug_query *query,
> >                   !match_wildcard(query->module, dt->mod_name))
> >                       continue;
> >
> > +             if (query->class_string) {
> > +                     map = ddebug_find_valid_class(dt, query->class_string, &valid_class);
> > +                     if (!map)
> > +                             continue;
>
> So remove the else here.
>
> > +             } else {
> > +                     /* constrain query, do not touch class'd callsites */
> > +                     valid_class = _DPRINTK_CLASS_DFLT;
> > +             }
> > +
> >               for (i = 0; i < dt->num_ddebugs; i++) {
> >                       struct _ddebug *dp = &dt->ddebugs[i];
> >
> > +                     /* match site against query-class */
> > +                     if (dp->class_id != valid_class)
>
> And then make this: if (query->class_string && (dp->class_id != valid_class))
>
> thoughts?
>
>
> > +                             continue;
> > +>                    /* match against the source filename */
> >                       if (query->filename &&
> >                           !match_wildcard(query->filename, dp->filename) &&
> > @@ -420,6 +454,8 @@ static int ddebug_parse_query(char *words[], int nwords,
> >               } else if (!strcmp(keyword, "line")) {
> >                       if (parse_linerange(query, arg))
> >                               return -EINVAL;
> > +             } else if (!strcmp(keyword, "class")) {
> > +                     rc = check_set(&query->class_string, arg, "class");
> >               } else {
> >                       pr_err("unknown keyword \"%s\"\n", keyword);
> >                       return -EINVAL;
> > @@ -854,6 +890,20 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
> >       return dp;
> >  }
> >
> > +#define class_in_range(class_id, map)                                        \
> > +     (class_id >= map->base && class_id < map->base + map->length)
> > +
> > +static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
> > +{
> > +     struct ddebug_class_map *map;
> > +
> > +     list_for_each_entry(map, &iter->table->maps, link)
> > +             if (class_in_range(dp->class_id, map))
> > +                     return map->class_names[dp->class_id - map->base];
> > +
> > +     return NULL;
> > +}
> > +
> >  /*
> >   * Seq_ops show method.  Called several times within a read()
> >   * call from userspace, with ddebug_lock held.  Formats the
> > @@ -865,6 +915,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
> >       struct ddebug_iter *iter = m->private;
> >       struct _ddebug *dp = p;
> >       struct flagsbuf flags;
> > +     char const *class;
> >
> >       if (p == SEQ_START_TOKEN) {
> >               seq_puts(m,
> > @@ -877,7 +928,16 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
> >                  iter->table->mod_name, dp->function,
> >                  ddebug_describe_flags(dp->flags, &flags));
> >       seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
> > -     seq_puts(m, "\"\n");
> > +     seq_puts(m, "\"");
> > +
> > +     if (dp->class_id != _DPRINTK_CLASS_DFLT) {
> > +             class = ddebug_class_name(iter, dp);
> > +             if (class)
> > +                     seq_printf(m, " class:%s", class);
> > +             else
> > +                     seq_printf(m, " class unknown, _id:%d", dp->class_id);
> > +     }
> > +     seq_puts(m, "\n");
> >
> >       return 0;
> >  }
