Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7F67EFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjA0UtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjA0UtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:49:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027BB1E1E6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:48:59 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z11so5828309ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMh4M5WsSDo4U0GXmOrRRBzpgYkhw4arjDkU31x08OA=;
        b=IBWBxNBxlbOTkZgYUEv2wRVK2NZqf81QbIs2HV5T3TyFxjLAEcUW47zYlcT2VgsLot
         0oou+Bi8vBu8YLo3P4M8b4X+1XJXZVEzbrZtKu5aAh1QELmp+c5KmQ+Lc3aN6pQcaoiJ
         +RPN0SsXQqrU7Q9pivC7LPFDDmmvA7Ht4KFbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMh4M5WsSDo4U0GXmOrRRBzpgYkhw4arjDkU31x08OA=;
        b=sCIFLEDTirW3OzWgzmrurOqZtNIT7YMemlMeRSxmmy9OUvzzhbu6zSX0wH8+tt1tuf
         QxCa2TkCP9F/KTxppOE0mR6hD4Ox7NKTWNn4zH1+sLng8NBA3yYZAAo8zCl2a2TQR0F2
         WrJwFrrdl5rq9RzsTtWJgldb0zNkMOEFw/M/bS5xZ6uhTPBNY19LSk0/vOQxG2H/+4LU
         vLofHzQx1x/8aSCp+PAn+iavRURDW2JHx0cPm0iQ1swc1lhSYbdTrseWGgyHgO92OfNK
         KTRGiFLFK4Ua04/UIBOyl1KcpsZ9dlzqfbu3i//NPoK7PyWVjEWdbpyA1uedQLNwOYVg
         OkcA==
X-Gm-Message-State: AFqh2kodOqXA8eaIsOJzO1oT4gGXK+wdls9c8UH2cJ5whhi+7wryXksI
        /eXB/rYw5vElrzSHitLFyxgkt8e19MKBnfS4VdE=
X-Google-Smtp-Source: AMrXdXvSuEr30Q/q+0MG5cDRaCzAYNn6EM+sAMKSDGoBB56qUsC2ia+gVrMiqAa5meYmBcr+pc0nyA==
X-Received: by 2002:a05:6402:2b92:b0:497:43ec:9e1d with SMTP id fj18-20020a0564022b9200b0049743ec9e1dmr44513880edb.0.1674852537208;
        Fri, 27 Jan 2023 12:48:57 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b0046c4553010fsm2906065edb.1.2023.01.27.12.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:48:56 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id bk15so16880611ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:48:56 -0800 (PST)
X-Received: by 2002:a17:906:848f:b0:86e:c9e2:6307 with SMTP id
 m15-20020a170906848f00b0086ec9e26307mr6220418ejx.187.1674852536251; Fri, 27
 Jan 2023 12:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20230126193518.53da979d@gandalf.local.home>
In-Reply-To: <20230126193518.53da979d@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Jan 2023 12:48:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5o7ZcRdpN0ch8iSFX4g73EXK=RHb6yDmHxneCZ44Org@mail.gmail.com>
Message-ID: <CAHk-=wh5o7ZcRdpN0ch8iSFX4g73EXK=RHb6yDmHxneCZ44Org@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 6.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Natalia Petrova <n.petrova@fintech.ru>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 4:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Please pull the latest trace-v6.2-rc5 tree, which can be found at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc5

-ENOSUCHTAG.

I do find the commit SHA in the 'trace/urgent' branch, but you
apparently never pushed out the tag.

            Linus
