Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DF65BE40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjACKem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:34:18 -0500
Received: from serv15.avernis.de (serv15.avernis.de [IPv6:2a01:4f8:151:30a2::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8AB21;
        Tue,  3 Jan 2023 02:34:15 -0800 (PST)
Received: from iago.. (unknown [95.91.249.42])
        by serv15.avernis.de (Postfix) with ESMTPSA id 36866BDE03E8;
        Tue,  3 Jan 2023 11:34:13 +0100 (CET)
From:   Andreas Ziegler <br015@umbiko.net>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <br015@umbiko.net>
Subject: [PATCH 0/2 v2] rtla osnoise hist average calculation
Date:   Tue,  3 Jan 2023 11:33:58 +0100
Message-Id: <20230103103400.275566-1-br015@umbiko.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
References: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at serv15.avernis.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of the proposed patch, with changes split in two separate commits, 
as suggested by Daniel Bristot de Oliveira

rtla osnoise hist always outputs '0' as average duration value. Example:

# rtla osnoise hist -P F:1 -c 0-1 -r 900000 -d 1M -b 1 -E 5000 -T 1
# RTLA osnoise histogram
# Time unit is microseconds (us)
# Duration:   0 00:01:00
  ...
count:     5629      1364
min:          1         1
avg:          0         0
max:       2955        56

This is due to sum_sample in osnoise_hist_update_multiple() being calculated 
as the sum (duration), not as sum (duration * count).

Truncating of the average value in final output suggests too optimistic 
results; display floating point value instead.

Andreas Ziegler (2):
  tools/tracing/rtla: osnoise_hist: use total duration for average
    calculation
  tools/tracing/rtla: osnoise_hist: display average with two-digit
    precision

 tools/tracing/rtla/src/osnoise_hist.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1

