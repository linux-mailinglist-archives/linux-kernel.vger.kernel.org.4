Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B165738755
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFUOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFUOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:41:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31C2105;
        Wed, 21 Jun 2023 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687358444; x=1718894444;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcYAwXLJCQtwMhxBdRxn+LT7Iv+clwkYaPMHiZpZl20=;
  b=PFofnBVSy9lqkCew083fk7mchPTHRuK/pqktW3kzNLqgklDAWvhnh58Q
   wt5TbnfLpaiOYoBNClqgli59T94vxKSJW+IJ21vLOQuS294+/SKD6SX2K
   Qk/94ZffHrccEpybCzme2pPzDBQ/59fzImZ0+uHUsY2rKjlc0cT6TWDfk
   D+/21gc5MLV69xvl3z8TXLDH3kKyYNyBHKx43yoj1ZhBp035NcJ8hk138
   vriCJDMRvJy146zQSz+Hco+f+rSuzJYotq3HT1HoVQQLRjV/j4rJWQuMR
   q38EqVNCAj0bKDWqx9vAsNp4z5TtKCUCcIe0VDpGFrTUCX371oHFdzfwj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339808311"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="339808311"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="888682114"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888682114"
Received: from lfrecald-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.26.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:40:43 -0700
Message-ID: <c62a7f5a33096d08ddb1f962dea85033df2c838f.camel@linux.intel.com>
Subject: Re: [PATCH 7/7] selftests/thermel/intel: Add test to read workload
 hint
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Jun 2023 07:40:43 -0700
In-Reply-To: <41d7a9144881cd536e545b57e193afc956646478.camel@intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
         <20230620230150.3068704-8-srinivas.pandruvada@linux.intel.com>
         <41d7a9144881cd536e545b57e193afc956646478.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 14:30 +0000, Zhang, Rui wrote:
> On Tue, 2023-06-20 at 16:01 -0700, Srinivas Pandruvada wrote:
> > Some SoCs have in built firmware support to classify current
> > running
> > workload and pass to OS for making power management decisions.
> > 
> > This test program waits for notification of workload type change
> > and prints. This program can be used to test this feature and also
> > allows other user space programs to use as a reference.
> > 
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> >  .../testing/selftests/thermal/intel/Makefile  |  16 +++
> >  .../thermal/intel/workload_hint_test.c        | 114
> > ++++++++++++++++++
> >  2 files changed, 130 insertions(+)
> >  create mode 100644 tools/testing/selftests/thermal/intel/Makefile
> >  create mode 100644
> > tools/testing/selftests/thermal/intel/workload_hint_test.c
> > 
> > diff --git a/tools/testing/selftests/thermal/intel/Makefile
> > b/tools/testing/selftests/thermal/intel/Makefile
> > new file mode 100644
> > index 000000000000..02459e271ef7
> > --- /dev/null
> > +++ b/tools/testing/selftests/thermal/intel/Makefile
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +ifndef CROSS_COMPILE
> > +uname_M := $(shell uname -m 2>/dev/null || echo not)
> > +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e
> > s/x86_64/x86/)
> > +
> > +ifeq ($(ARCH),x86)
> > +TEST_PROGS := workload_hint_test
> > +
> > +all: $(TEST_PROGS)
> > +
> > +include ../../lib.mk
> > +
> > +clean:
> > +       rm -fr $(TEST_PROGS)
> > +endif
> > +endif
> > diff --git
> > a/tools/testing/selftests/thermal/intel/workload_hint_test.c
> > b/tools/testing/selftests/thermal/intel/workload_hint_test.c
> > new file mode 100644
> > index 000000000000..69a48a8ccbb4
> > --- /dev/null
> > +++ b/tools/testing/selftests/thermal/intel/workload_hint_test.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <poll.h>
> > +
> > +#define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE
> > "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay
> > _m
> > s"
> > +#define WORKLOAD_ENABLE_ATTRIBUTE
> > "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enab
> > le
> > "
> > +#define WORKLOAD_TYPE_INDEX_ATTRIBUTE 
> > "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_type_inde
> > x"
> > +
> > +static const char * const workload_types[] = {
> > +       "idle",
> > +       "battery_life",
> > +       "sustained",
> > +       "bursty",
> > +       NULL
> > +};
> > +
> > +#define WORKLOAD_TYPE_MAX_INDEX        3
> > +
> > +int main(int argc, char **argv) {
> > +       struct pollfd ufd;
> > +       char index_str[4];
> > +       int fd, ret, index;
> > +       int delay = 0;
> > +
> > +       if (argc > 1) {
> > +               char delay_str[64];
> > +
> > +               sscanf(argv[1], "%d", &delay);
> > +               printf("Setting notification delay to %d ms\n",
> > delay);
> > +
> > +               if (delay < 0)
> > +                       exit(1);
> > +
> > +               sprintf(delay_str, "%s\n", argv[1]);
> > +
> > +               if ((fd =
> > open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE,
> > O_RDWR)) < 0) {
> > +                       perror("Unable to open workload
> > notification
> > delay\n");
> > +                       exit(1);
> > +               }
> > +
> > +               if (write(fd, delay_str, strlen(delay_str)) < 0) {
> > +                       perror("Can't set delay\n");
> > +                       exit(1);
> > +               }
> > +
> > +               close(fd);
> > +
> > +       }
> > +
> > +       /* Enable feature via sysfs knob */
> > +       if ((fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR)) < 0) {
> > +               perror("Unable to open workload type feature enable
> > file\n");
> > +               exit(1);
> > +       }
> > +
> > +       if (write(fd, "1\n", 2) < 0) {
> > +               perror("Can' enable workload hints\n");
> > +               exit(1);
> > +       }
> > +
> > +       close(fd);
> 
> This enables WORKLOAD_ENABLE_ATTRIBUTE without disabling it again.
> As a test program, maybe we can add a timeout, and stop polling &
> disable the WORKLOAD_ENABLE_ATTRIBUTE after the timeout?
> 
We can or use signal to catch ctrl-c and do disable.

Thanks,
Srinivas

> thanks,
> rui
> > +
> > +       while (1) {
> > +               if ((fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE,
> > O_RDONLY)) < 0) {
> > +                       perror("Unable to open workload type
> > file\n");
> > +                       exit(1);
> > +               }
> > +
> > +               if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> > +                       fprintf(stderr, "Failed to set pointer to
> > beginning\n");
> > +                       exit(1);
> > +               }
> > +
> > +               if (read(fd, index_str, sizeof(index_str)) < 0) {
> > +                       fprintf(stderr, "Failed to read from:%s\n",
> > +                       WORKLOAD_TYPE_INDEX_ATTRIBUTE);
> > +                       exit(1);
> > +               }
> > +
> > +               ufd.fd = fd;
> > +               ufd.events = POLLPRI;
> > +
> > +               if ((ret = poll(&ufd, 1, -1)) < 0) {
> > +                       perror("poll error");
> > +                       exit(1);
> > +               } else if (ret == 0) {
> > +                       printf("Poll Timeout\n");
> > +               } else {
> > +                       if ((lseek(fd, 0L, SEEK_SET)) < 0) {
> > +                               fprintf(stderr, "Failed to set
> > pointer to beginning\n");
> > +                               exit(1);
> > +                       }
> > +
> > +                       if (read(fd, index_str, sizeof(index_str))
> > <
> > 0) {
> > +                               exit(0);
> > +                       }
> > +
> > +                       sscanf(index_str, "%d", &index);
> > +                       if (index > WORKLOAD_TYPE_MAX_INDEX)
> > +                               printf("Invalid workload type
> > index\n");
> > +                       else
> > +                               printf("workload type:%s\n",
> > workload_types[index]);
> > +               }
> > +
> > +               close(fd);
> > +       }
> > +}
> 

