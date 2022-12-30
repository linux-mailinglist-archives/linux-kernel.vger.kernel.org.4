Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AB658F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiL2RMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiL2RMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:12:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CAF13E3A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72819B81A1D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3609C433D2;
        Thu, 29 Dec 2022 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672333950;
        bh=Yxg0KWVGkE4OjNS50RAJU+5XIbWHTk2kRfNohBs7EDw=;
        h=From:To:Cc:Subject:Date:From;
        b=Kaz/FpFQmQlegHlVB0XTSi7Ksy/CUEp2DGrgqzz3tUWPBaZvgD1nFjL+bz4dkK/IP
         XJU4ZXcFcpB/srFY3anvb7MMIkuVcFtRG7TOm17KwRh4SWVB8z+wL+OzyNgGNOlv/Z
         SitCM1pV3jTUrwWu4QRksQpTBGDO+b4Mt0KDPLkcYlQZOV6lT7tP19STwMeguF5orb
         OfVUt7oEOfFCXiRXgFJ7l120nvjmDJLu86nJeLNZtEfkl5fZzwgzm5uA0kT/j8SZE9
         /aLzlsSmzIzHOeHP83yQQWBVbMW1XF6mXGyV2chd8GAVHWzduxgazaMYDgzjMQE1cg
         Y4UGRXjiNkZ3Q==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-damon@amazon.com, linux-damon-trial@amazon.com
Subject: Looking back DAMON development in 2022
Date:   Thu, 29 Dec 2022 17:12:09 +0000
Message-Id: <20221229171209.162356-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


The last major Linux version of 2021, v5.15, was the debut of DAMON.  After
the release, one more thankful year of DAMON development has passed.  I'd like
to share some major events and statistics of DAMON development that we had in
2022, and say thank you to the community.

Summary
=======

2022 was a year of active and healthy DAMON development.

Seven new DAMON major features were delivered to users.  Some of those were
featured in articles and academic papers.

It was possible thanks to the DAMON community.  The community has expanded with
its own mailing list and an open bi-weekly chat series.  40 people contributed
their great code to DAMON via making their 275 commits merged into the
mainline.  About 33% of the commits were made by Amazon-external contributors.

The amount of DAMON changes in 2022 (v5.15..v6.2-rc1) was not that tiny
compared to other subsystems.  About 0.2% of the commits for whole Linux tree
was for DAMON.  Among the changes for DAMON's parent subsystem, mm, about 8% of
commits and 14% of lines of changes were made for DAMON.

Key Events
==========

In January of 2022, v5.16, the first major Linux version of 2022, has released
with major DAMON features including
 - DAMON-based Operation Schemes,
 - Physical address space monitoring support,
 - DAMOS quota/priorities/watermarks, and
 - Data Access-aware Reclaim module (DAMON_RECLAIM).

In April, DAMON and DAMON_RECLAIM were merged[1] into Android.

In May, v5.18 was released with DAMON sysfs interface, which is aimed to be the
flexible and stable DAMON interface for long term usage.  We also made a
mailing list which is dedicated for DAMON development (damon@lists.linux.dev).

In June, we presented DAMON-related works in an academic conference, HPDC[2].

In July, v5.19 as released with DAMON online tuning feature.  This opened the
chance for more optimal and automated tuning of DAMON.  DAMON has also
featured[3] on Embedded Linux Conference'22 keynote.

In August, DAMON community started its bi-weekly virtual chat series[4].
DAMON-based Proactive LRU-lists Sorting patchset, which reduces about 20% of
pressure stall time, has merged into the mainline and featured by LWN[5].

In September, DAMON's current status and future plans were presented[6] at
KernelSummit.

In October, v6.0 was released with DAMON-based Proactive LRU lists sorting.  We
also had a first in-person DAMON community meetup[7] in LPC.

In November and December, DAMOS tried regions patchset, which makes query-like
efficient monitoring results collection available, and DAMOS filters patchset,
which allows finer tuning and cgroups support of DAMON-based memory
managements, have developed.  The first one has merged in v6.2-rc1 in December.
The second one will hopefully be merged into v6.3 in 2023.

[1] https://android.googlesource.com/kernel/common/+/0496c13ded02bd72426d189b777bf303fe490f62
[2] https://www.amazon.science/publications/daos-data-access-aware-operating-system
[3] https://lwn.net/Articles/899742/
[4] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/
[5] https://lwn.net/Articles/905370/
[6] https://lpc.events/event/16/contributions/1224/
[7] https://lpc.events/event/16/contributions/1388/

Development Statistics
======================

To appreciate and list all names of people who made DAMON available, and to
quantify what 2022 was for DAMON development, I collected some numbers using my
humble and buggy scripts.  The scripts are available as open source[1,2].

[1] https://github.com/sjp38/lazybox
[2] https://git.kernel.org/sj/damon-hack/h/master

Contributors
------------

According to the humble script, 40 people have contributed to DAMON development
in 2022 (v5.15..v6.2-rc1).

$ ./lazybox/git_helpers/authors.py ./linux --commits_range v5.15..v6.2-rc1 \
        --skip_merge_commits --max_nr_authors 40
        --files mm/damon/ \
            include/trace/events/damon.h include/linux/damon.h \
            Documentation/admin-guide/mm/damon/ Documentation/mm/damon/ \
            Documentation/vm/damon/ \
            Documentation/ABI/testing/sysfs-kernel-mm-damon \
            tools/testing/selftests/damon
1. SeongJae Park <sj@kernel.org>: 192 commits
2. Xin Hao <xhao@linux.alibaba.com>: 19 commits
3. Kaixu Xia <kaixuxia@tencent.com>: 15 commits
4. Baolin Wang <baolin.wang@linux.alibaba.com>: 5 commits
5. Matthew Wilcox (Oracle) <willy@infradead.org>: 4 commits
6. Changbin Du <changbin.du@gmail.com>: 4 commits
7. Yang Yingliang <yangyingliang@huawei.com>: 2 commits
8. SeongJae Park <sjpark@amazon.de>: 2 commits
9. Rong Tao <rongtao@cestc.cn>: 1 commits
10. Christophe JAILLET <christophe.jaillet@wanadoo.fr>: 1 commits
11. Jason A. Donenfeld <Jason@zx2c4.com>: 1 commits
12. Dawei Li <set_pte_at@outlook.com>: 1 commits
13. Yajun Deng <yajun.deng@linux.dev>: 1 commits
14. Levi Yun <ppbuk5246@gmail.com>: 1 commits
15. Liam R. Howlett <Liam.Howlett@Oracle.com>: 1 commits
16. Kenneth Lee <klee33@uw.edu>: 1 commits
17. Greg Kroah-Hartman <gregkh@linuxfoundation.org>: 1 commits
18. Badari Pulavarty <badari.pulavarty@intel.com>: 1 commits
19. Kairui Song <kasong@tencent.com>: 1 commits
20. Jianglei Nie <niejianglei2021@163.com>: 1 commits
21. Gautam <gautammenghani201@gmail.com>: 1 commits
22. Mike Rapoport <rppt@linux.ibm.com>: 1 commits
23. Chengming Zhou <zhouchengming@bytedance.com>: 1 commits
24. Kefeng Wang <wangkefeng.wang@huawei.com>: 1 commits
25. Gautam Menghani <gautammenghani201@gmail.com>: 1 commits
26. Jiapeng Chong <jiapeng.chong@linux.alibaba.com>: 1 commits
27. Hailong Tu <tuhailong@gmail.com>: 1 commits
28. Yu Zhe <yuzhe@nfschina.com>: 1 commits
29. Xiaomeng Tong <xiam0nd.tong@gmail.com>: 1 commits
30. Jonghyeon Kim <tome01@ajou.ac.kr>: 1 commits
31. tangmeng <tangmeng@uniontech.com>: 1 commits
32. Miaohe Lin <linmiaohe@huawei.com>: 1 commits
33. Guoqing Jiang <guoqing.jiang@linux.dev>: 1 commits
34. Yihao Han <hanyihao@vivo.com>: 1 commits
35. Jakub Kicinski <kuba@kernel.org>: 1 commits
36. Colin Ian King <colin.i.king@googlemail.com>: 1 commits
37. Rongwei Wang <rongwei.wang@linux.alibaba.com>: 1 commits
38. Rikard Falkeborn <rikard.falkeborn@gmail.com>: 1 commits
39. Colin Ian King <colin.king@canonical.com>: 1 commits
40. Geert Uytterhoeven <geert@linux-m68k.org>: 1 commits
# 40 authors, 275 commits in total

Please note that there were many more unsung hero contributors who contributed
valuable inputs, discussions, and many more things for DAMON development.  So
shame that I cannot put everyone's name here.

Thank you so much to all awesome contributors!

Contributions from non-maintainer
---------------------------------

The maintainer, SJ (sj@kernel.org), has driven the development of DAMON, but
the help from the community was huge.  About 33% of DAMON commits have made by
people other than the maintainer.

$ ./damon-hack/stat_damon_portion_community_commits.sh ./linux ./damon-hack/stat_branches_2022
range               from_sj non_sj    non_sj_portion
v5.15..v5.16        50      13        20.63%
v5.16..v5.17        16      10        38.46%
v5.17..v5.18        26      10        27.78%
v5.18..v5.19        23      7         23.33%
v5.19..v6.0         15      14        48.28%
v6.0..v6.1          33      36        52.17%
v6.1..v6.2-rc1      28      6         17.65%
v5.15..v6.2-rc1     191     95        33.22%

Portion of DAMON Commits in MM and Linux
----------------------------------------

To show how much change DAMON made to its parent subsystem, MM, and whole
Linux, I counted the number of commits that touched mm/damon, mm/ and any file
of the Linux tree in 2022 releases (v5.15..v6.2-rc1).  Note that I counted
changes touching only mm/damon/ and mm/ for DAMON and MM appropriately (doesn't
count changes for documents, headers, tests, etc), for simplicity.

According to the buggy and humble script, about 8% of MM commits, and 0.2% of
Linux commits were made for DAMON.

$ ./damon-hack/stat_damon_portion_nr_commits.sh ./linux ./damon-hack/stat_branches_2022
range               damon mm   damon/mm linux  damon/linux
v5.15..v5.16        45    307  14.66%   14190  0.32%
v5.16..v5.17        17    223  7.62%    13038  0.13%
v5.17..v5.18        29    448  6.47%    14954  0.19%
v5.18..v5.19        24    399  6.02%    15134  0.16%
v5.19..v6.0         15    283  5.30%    15402  0.10%
v6.0..v6.1          61    536  11.38%   13942  0.44%
v6.1..v6.2-rc1      20    250  8.00%    13687  0.15%
v5.15..v6.2-rc1     211   2446 8.63%    100347 0.21%

By Number of Lines
------------------

I further counted the portion of the number of changed lines.  Didn't count
that for Linux here due to the slow speed of the script.  Please also note that
I count changes touching only mm/damon/ and mm/ as same to above case.  The
script argues about 14% of the changes lines for MM subsystem were for DAMON.

$ ./damon-hack/stat_damon_portion_lines.sh ./linux ./damon-hack/stat_branches_2022
range               damon mm    damon/mm
v5.15..v5.16        2157  8503  25.37%
v5.16..v5.17        324   9370  3.46%
v5.17..v5.18        3462  16288 21.25%
v5.18..v5.19        929   10185 9.12%
v5.19..v6.0         870   8665  10.04%
v6.0..v6.1          1752  25844 6.78%
v6.1..v6.2-rc1      3309  10544 31.38%
v5.15..v6.2-rc1     12803 89399 14.32%

Conclusion
==========

DAMON community delivered a number of important features and quite a number of
changes to the world via the collaboration between the 40 great contributors.
I would call 2022 as one of the greatest years of DAMON development.

Huge thanks to you again, DAMON community.  Looking forward to continuing our
journey in 2023.

Hope you all enjoy the remaining holidays and happy new year!


Thanks,
SJ
