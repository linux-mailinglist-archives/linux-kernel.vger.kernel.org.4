Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EAA70276C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjEOIlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjEOIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:41:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D27E6C;
        Mon, 15 May 2023 01:40:53 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pyTlC-0004Ot-9Q; Mon, 15 May 2023 10:40:50 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v1] docs: handling-regressions: rework section about fixing procedures
Date:   Mon, 15 May 2023 10:40:48 +0200
Message-Id: <6971680941a5b7b9cb0c2839c75b5cc4ddb2d162.1684139586.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1684140053;801c34d6;
X-HE-SMSGID: 1pyTlC-0004Ot-9Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This basically rewrites the 'Prioritize work on fixing regressions'
section of Documentation/process/handling-regressions.rst for various
reasons. Among them: some things were too demanding, some didn't align
well with the usual workflows, and some apparently were not clear enough
-- and of course a few things were missing that would be good to have in
there.

Linus for example recently stated that regressions introduced during the
past year should be handled similarly to regressions from the current
cycle, if it's a clear fix with no semantic subtlety. His exact
wording[1] didn't fit well into the text structure, but the author tried
to stick close to the apparent intention.

It was a noble goal from the original author to state "[prevent
situations that might force users to] continue running an outdated and
thus potentially insecure kernel version for more than two weeks after a
regression's culprit was identified"; this directly led to the goal "fix
regression in mainline within one week, if the issue made it into a
stable/longterm kernel", because the stable team needs time to pick up
and prepare a new release. But apparently all that was a bit too
demanding.

That "one week" target for example doesn't align well with the usual
habits of the subsystem maintainers, which normally send their fixes to
Linus once a week; and it doesn't align too well with stable/longterm
releases either, which often enter a -rc phase on Mondays or Tuesdays
and then are released two to three days later. And asking developers to
create, review, and mainline fixes within one week might be too much to
ask for in general. Hence tone the general goal down to three weeks and
use an approach that better aligns with the usual merging and release
habits.

While at it, also make the rules of thumb a bit easier to follow by
grouping them by topic (e.g. generic things, timing, procedures, ...).

Also add text for a few cases where recent discussions showed they need
covering. Among them are multiple points that better explain the
relations to stable and longterm kernels and the team that manages them;
they and the group seperators are the primary reason why this whole
section sadly grew somewhat in the rewrite.

The group about those relations led to one addition the author came up
with without any precedent from Linus: the text now tells developers to
add a stable tag for any regression that made it into a proper mainline
release during the past 12 months. This is meant to ensure the stable
team will definitely notice any fixes for recent regressions. That
includes those introduced shortly before a new mainline release and
found right after it; without such a rule the stable team might miss the
fix, which then would only reach users after weeks or months with later
releases.

Note, the aspect "Do not consider regressions from the current cycle as
something that can wait till the cycle's end [...]" might look like an
addition, but was kinda was in the old text as well -- but only
indirectly. That apparently was too subtle, as many developers seem to
assume waiting till the end of the cycle is fine (even for build
fixes).

In practice this was especially problematic when a cause of a regression
made it into a proper release (either directly or through a backport). A
revert performed by Linus shortly before the 6.3 release illustrated
that[2], as the developer of the culprit had been willing to revert the
culprit about three weeks earlier already -- but didn't do so when a fix
came into sight and a maintainer suggested it can wait. Due to that the
issue in the end plagued users of 6.2.y at least two weeks longer than
necessary, as the fix in the end didn't become ready in time. This issue
in fact could have been resolved one or two additional weeks earlier, if
the developer had reverted the culprit shortly after it had been
identified (which even the old version of the text suggest to do in such
cases).

[1] https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

[2] https://lore.kernel.org/all/CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com/

CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Greg KH <gregkh@linuxfoundation.org>
CC: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

---
Lo! Over time I became more and more unhappy with this section of
Documentation/process/handling-regressions.rst I wrote about one and
a half years ago. And it seems developers were unhappy about quite a bit
of it as well and thus didn't take it seriously. No wonder I ended up
basically rewriting the section when I recently set out to add a few
aspects Linus recently clarified.

Apart from what the patch description above already highlights, the
rules of thumb in the end don't change. But I'm looking at the text a
lot for three weeks now, hence I might have become too blind to spot
unwanted changes.

Hence let me know if you think I went too far somewhere (especially with
the "tag recent regressions for backporting if they recently made it
into a mainline release" thing)  -- or if you think some things should
be stricter or more relaxed in general.

Ciao, Thorsten
---
 .../process/handling-regressions.rst          | 208 +++++++++++-------
 1 file changed, 126 insertions(+), 82 deletions(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index abb741b1aeee..5d3c3de3f4ec 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -129,88 +129,132 @@ tools and scripts used by other kernel developers or Linux distributions; one of
 these tools is regzbot, which heavily relies on the "Link:" tags to associate
 reports for regression with changes resolving them.
 
-Prioritize work on fixing regressions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You should fix any reported regression as quickly as possible, to provide
-affected users with a solution in a timely manner and prevent more users from
-running into the issue; nevertheless developers need to take enough time and
-care to ensure regression fixes do not cause additional damage.
-
-In the end though, developers should give their best to prevent users from
-running into situations where a regression leaves them only three options: "run
-a kernel with a regression that seriously impacts usage", "continue running an
-outdated and thus potentially insecure kernel version for more than two weeks
-after a regression's culprit was identified", and "downgrade to a still
-supported kernel series that lack required features".
-
-How to realize this depends a lot on the situation. Here are a few rules of
-thumb for you, in order or importance:
-
- * Prioritize work on handling regression reports and fixing regression over all
-   other Linux kernel work, unless the latter concerns acute security issues or
-   bugs causing data loss or damage.
-
- * Always consider reverting the culprit commits and reapplying them later
-   together with necessary fixes, as this might be the least dangerous and
-   quickest way to fix a regression.
-
- * Developers should handle regressions in all supported kernel series, but are
-   free to delegate the work to the stable team, if the issue probably at no
-   point in time occurred with mainline.
-
- * Try to resolve any regressions introduced in the current development before
-   its end. If you fear a fix might be too risky to apply only days before a new
-   mainline release, let Linus decide: submit the fix separately to him as soon
-   as possible with the explanation of the situation. He then can make a call
-   and postpone the release if necessary, for example if multiple such changes
-   show up in his inbox.
-
- * Address regressions in stable, longterm, or proper mainline releases with
-   more urgency than regressions in mainline pre-releases. That changes after
-   the release of the fifth pre-release, aka "-rc5": mainline then becomes as
-   important, to ensure all the improvements and fixes are ideally tested
-   together for at least one week before Linus releases a new mainline version.
-
- * Fix regressions within two or three days, if they are critical for some
-   reason -- for example, if the issue is likely to affect many users of the
-   kernel series in question on all or certain architectures. Note, this
-   includes mainline, as issues like compile errors otherwise might prevent many
-   testers or continuous integration systems from testing the series.
-
- * Aim to fix regressions within one week after the culprit was identified, if
-   the issue was introduced in either:
-
-    * a recent stable/longterm release
-
-    * the development cycle of the latest proper mainline release
-
-   In the latter case (say Linux v5.14), try to address regressions even
-   quicker, if the stable series for the predecessor (v5.13) will be abandoned
-   soon or already was stamped "End-of-Life" (EOL) -- this usually happens about
-   three to four weeks after a new mainline release.
-
- * Try to fix all other regressions within two weeks after the culprit was
-   found. Two or three additional weeks are acceptable for performance
-   regressions and other issues which are annoying, but don't prevent anyone
-   from running Linux (unless it's an issue in the current development cycle,
-   as those should ideally be addressed before the release). A few weeks in
-   total are acceptable if a regression can only be fixed with a risky change
-   and at the same time is affecting only a few users; as much time is
-   also okay if the regression is already present in the second newest longterm
-   kernel series.
-
-Note: The aforementioned time frames for resolving regressions are meant to
-include getting the fix tested, reviewed, and merged into mainline, ideally with
-the fix being in linux-next at least briefly. This leads to delays you need to
-account for.
-
-Subsystem maintainers are expected to assist in reaching those periods by doing
-timely reviews and quick handling of accepted patches. They thus might have to
-send git-pull requests earlier or more often than usual; depending on the fix,
-it might even be acceptable to skip testing in linux-next. Especially fixes for
-regressions in stable and longterm kernels need to be handled quickly, as fixes
-need to be merged in mainline before they can be backported to older series.
+Expectations and best practices for fixing regressions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As a Linux kernel developer, you are expected to give your best to prevent
+situations where a regression caused by a recent change of yours leaves users
+only these options:
+
+ * Run a kernel with a regression that impacts usage.
+
+ * Switch to an older or newer kernel series.
+
+ * Continue running an outdated and thus potentially insecure kernel for more
+   than three weeks after the regression's culprit was identified. Ideally it
+   should be less than two. And it ought to be just a few days, if the issue is
+   severe or affects many users -- either in general or in prevalent
+   environments.
+
+How to realize that in practice depends on various factors. Use the following
+rules of thumb as a guide.
+
+In general:
+
+ * Prioritize work on regressions over all other Linux kernel work, unless the
+   latter concerns a severe issue (e.g. acute security vulnerability, data loss,
+   bricked hardware, ...).
+
+ * Expedite fixing mainline regressions that recently made it into a proper
+   mainline, stable, or longterm release (either directly or via backport).
+
+ * Do not consider regressions from the current cycle as something that can wait
+   till the end of the cycle, as the issue might discourage or prevent users and
+   CI systems from testing mainline now or generally.
+
+ * Work with the required care to avoid additional or bigger damage, even if
+   resolving an issue then might take longer than outlined below.
+
+On timing once the culprit of a regression is known:
+
+ * Aim to mainline a fix within two or three days, if the issue is severe or
+   bothering many users -- either in general or in prevalent conditions like a
+   particular hardware environment, distribution, or stable/longterm series.
+
+ * Aim to mainline a fix by Sunday after the next, if the culprit made it
+   into a recent mainline, stable, or longterm release (either directly or via
+   backport); if the culprit became known early during a week and is simple to
+   resolve, try to mainline the fix within the same week.
+
+ * For other regressions, aim to mainline fixes before the hindmost Sunday
+   within the next three weeks. One or two Sundays later are acceptable, if the
+   regression is something people can live with easily for a while -- like a
+   mild performance regression.
+
+ * It's strongly discouraged to delay mainlining regression fixes till the next
+   merge window, except when the fix is extraordinarily risky or when the
+   culprit was mainlined more than a year ago.
+
+On procedure:
+
+ * Always consider reverting the culprit, as it's often the quickest and least
+   dangerous way to fix a regression. Don't worry about mainlining a fixed
+   variant later: that should be straight-forward, as most of the code went
+   through review once already.
+
+ * Try to resolve any regressions introduced in mainline during the past
+   twelve months before the current development cycle ends: Linus wants such
+   regressions to be handled like those from the current cycle, unless fixing
+   bears unusual risks.
+
+ * Consider CCing Linus on discussions or patch review, if a regression seems
+   tangly. Do the same in precarious or urgent cases -- especially if the
+   subsystem maintainer might be unavailable. Also CC the stable team, when you
+   know such a regression made it into a mainline, stable, or longterm release.
+
+ * For urgent regressions, consider asking Linus to pick up the fix straight
+   from the mailing list: he is totally fine with that for uncontroversial
+   fixes. Ideally though such requests should happen in accordance with the
+   subsystem maintainers or come directly from them.
+
+ * In case you are unsure if a fix is worth the risk applying just days before
+   a new mainline release, send Linus a mail with the usual lists and people in
+   CC; in it, summarize the situation while asking him to consider picking up
+   the fix straight from the list. He then himself can make the call and when
+   needed even postpone the release. Such requests again should ideally happen
+   in accordance with the subsystem maintainers or come directly from them.
+
+Regarding stable and longterm kernels:
+
+ * You are free to leave regressions to the stable team, if they at no point in
+   time occurred with mainline or were fixed there already.
+
+ * If a regression made it into a proper mainline release during the past
+   twelve months, ensure to tag the fix with "Cc: stable@vger.kernel.org", as a
+   "Fixes:" tag alone does not guarantee a backport. Please add the same tag,
+   in case you know the culprit was backported to stable or longterm kernels.
+
+ * When receiving reports about regressions in recent stable or longterm kernel
+   series, please evaluate at least briefly if the issue might happen in current
+   mainline as well -- and if that seems likely, take hold of the report. If in
+   doubt, ask the reporter to check mainline.
+
+ * Whenever you want to swiftly resolve a regression that recently also made it
+   into a proper mainline, stable, or longterm release, fix it quickly in
+   mainline; when appropriate thus involve Linus to fast-track the fix (see
+   above). That's because the stable team normally does neither revert nor fix
+   any changes that cause the same problems in mainline.
+
+ * In case of urgent regression fixes you might want to ensure prompt
+   backporting by dropping the stable team a note once the fix was mainlined;
+   this is especially advisable during merge windows and shortly thereafter, as
+   the fix otherwise might land at the end of a huge patch queue.
+
+On patch flow:
+
+ * Developers, when trying to reach the time periods mentioned above, remember
+   to account for the time it takes to get fixes tested, reviewed, and merged by
+   Linus, ideally with them being in linux-next at least briefly. Hence, if a
+   fix is urgent, make it obvious to ensure others handle it appropriately.
+
+ * Reviewers, you are kindly asked to assist developers in reaching the time
+   periods mentioned above by reviewing regression fixes in a timely manner.
+
+ * Subsystem maintainers, you likewise are encouraged to expedite the handling
+   of regression fixes. Thus evaluate if skipping linux-next is an option for
+   the particular fix. Also consider sending git pull requests more often than
+   usual when needed. And try to avoid holding onto regression fixes over
+   weekends -- especially when the fix is marked for backporting.
 
 
 More aspects regarding regressions developers should be aware of

base-commit: cdc822dda6f82269b94d5fa60ddc71d98c160fa0
-- 
2.40.1

