Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669846D354A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjDBClR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 22:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBClQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 22:41:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E3195
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680403224; i=efault@gmx.de;
        bh=F+Umf3hqPFHg7SHeuykhKhJatkHnksiSqUpbWv1gAxk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BIEYbyOXiIo1kGuEzMcB1jGE+9h+YA6XkixIf4O5ksSMBkFSR2Jf042JD7OPYbzeu
         a4UN/ZmF9Ver9UEpwI9JnXeXGykzLBvl6wXKL7vtO/kNvgn0m++yr9Hc2BsCJ6wioC
         AVbciXk2eRMFfeqNaf5OKp5+KmPI+5rHi6OU6dC876jT2bcCYcXLYQyAkp7ao7Buq2
         MUlTglQyAjXIQyNCuHO1TI5xEAPYIKidfI5hh6ExttHTMoYW036KAJ6pTFDofidKib
         w1jm89rrSxTSmdlp+95XPWf1YyNXdi1g2JHuf7yuQlY2FVPdgpyzhDnJS4xbg/i4Yi
         FVGcM5CRvH+/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.150]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1qQYbg0mbg-00zq9q; Sun, 02
 Apr 2023 04:40:24 +0200
Message-ID: <ba994b0f4b4402612d2e14552882c29dca83ad5f.camel@gmx.de>
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
From:   Mike Galbraith <efault@gmx.de>
To:     Hillf Danton <hdanton@sina.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, linux-mm@kvack.org,
        joel@joelfernandes.org
Date:   Sun, 02 Apr 2023 04:40:20 +0200
In-Reply-To: <20230401232355.336-1-hdanton@sina.com>
References: <20230328092622.062917921@infradead.org>
         <20230328110354.562078801@infradead.org>
         <20230401232355.336-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b8jb18m/xLO6WWf/DBSGrQ206CvHmR3HAKRTfTwT2SXID/J1xTQ
 wDHtip+cCtSUZe3C2WbPiEWAXZXEmFdcq/4JFvJrhBifqyg6VDxb8Cd+nr8HBUnd+i90yu/
 8tnziH/4E5VpjYLpNfSlhS5pL2waZQAAhoK6fvO9S0DtvUYrCOZMVlnsqPa/LPymYMoYWmR
 wJy+Q6LVN6zZnf6i4CrBA==
UI-OutboundReport: notjunk:1;M01:P0:ek+gC82vFZs=;oIfltOHJL24YinxvqsFelGhEouy
 uXb0O0+r9lTgMmGMVVPJftypXPZdqMPFORGqTh0Ag4ysLMPXHDxmmOSDPI30GWwIpoJrN1uI7
 CRNK1a6+hBo20VlMc6UmSjBRlx98fpGW/flc/vc84luSNb+6wGvgD7x0wDJL14GVxcQ53D1m0
 4XAgv0Dm+464Bz0N2dDFe1Kts1jKZDoiU6D33t8uIlhL30J+suCjAmUhUJiFfzfKlh6Hit98m
 oRHLqhRPwq9ovBxnVsW13iQMvXq7Ea2ZZ/F1VuSR03a5sEYtzuVmnwkUWpsacLnQtR2KURKFF
 3ga/hBucgatY6pe4FxWrnt8j0RfaOB6ZT+G2BxB9orErRwteKrolrP9Cn/ERvDRqFSSqDmqNb
 f1KbDDK9cA+YurEyloGOiz8LzmScc5LW0faqY3CqKhO3OCKqKiYr71MVAFUhCUYyUIO9wcTdm
 Ar9KZzdSJFp6Y7GZzPCjvfoJZKxaVdkV6IuawwGeZ86XZ7ra+2ZmRUyUMrLNL8r+GIszu9wf/
 vM92ZnBHKAEj4kyfCRJyr0T9zICMBmjqVv1Be/edyAtaQ9clU1NkwDzHS5607PLnZezHmAVCh
 12y9cgbwlxzrslOA9bR/AO0AiveTIX2tiztF49get5/bOE0Fl+iSO+Hah3xri+puHzG5A2NHU
 lV7OaU09KrotHWL7/hHsE3Jb2hhUoNMYZ4K4kDBHhsw/X1pa0jPzT82m+6r8+w0uYJW3ezkUB
 F+XFXfh7yAsRbe4hs2FIr8zSuTxNFg82+TxD2RY73vYYXIG/zqJq1PnJBgwlLAjwxEOmqDmW7
 5DtJ8rXkj5d6LoSxhrQpBko1DqzD4q9q2PgqRrDhGUoDhBnXDMUl1URirMBXeByt1gxxLOvwc
 b2hKFGYP2jnKHxVZcU1O8TOgme9ikJwGJH1TQBhISn9owFYGz3n7nxYUIEE9n8VeRcCTk1A5D
 BKgbjg==
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-04-02 at 07:23 +0800, Hillf Danton wrote:
> On 31 Mar 2023 17:26:51 +0200 Vincent Guittot <vincent.guittot@linaro.or=
g>
> >
> > I wanted to stress this situation with a simple use case but it seems
> > that even without changing the slice, there is a fairness problem:
> >
> > Task A always run
> > Task B loops on : running 1ms then sleeping 1ms
> > default nice and latency nice prio bot both
> > each task should get around 50% of the time.
> >
> > The fairness is ok with tip/sched/core
> > but with eevdf, Task B only gets around 30%
>
> Convincing evidence for glitch in wakeup preempt.

If you turn on PLACE_BONUS, it'll mimic FAIR_SLEEPERS.. but if you then
do some testing, you'll probably turn it right back off.

The 50/50 split in current code isn't really any more fair, as soon as
you leave the tiny bubble of fairness, it's not the least bit fair.
Nor is that tiny bubble all rainbows and unicorns, it brought with it
benchmark wins and losses, like everything that changes more than
comments, its price being service latency variance.

The short term split doesn't really mean all that much, some things
will like the current fair-bubble better, some eevdf virtual deadline
math and its less spiky service.  We'll see.

I'm kinda hoping eevdf works out, FAIR_SLEEPERS is quite annoying to
squabble with.

	-Mike
