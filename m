Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32C688503
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBBRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBBRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:00:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A193E3B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F189B82752
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E265C433EF;
        Thu,  2 Feb 2023 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675357212;
        bh=KhsHJGMkk85ln+sCx+d+Nxt6KslFX/d/TmJqhuW9H0g=;
        h=From:Date:Subject:To:Cc:From;
        b=WqnME7peHGJ3afmo5qu3mf4FWfKSK1eJpoc39x9Bmt4vBzPiDj7D8D55yHJtL8u/H
         jNAnxzrKzMPclXaJ0PoV0IZ9UJ51kkdflUtE3DibWpuhwsogCR6eecyZVCU/zwXVjF
         2jBgDq0bIhtjOUghcnxF/Qg3xThRqbhEAzLxhklS2QbQu9lpxqL/bk8F6BFJ+Gvqj2
         KnyR4xepcklLlbCIjfuLiap6muprfQ6C85Y4hnzCxckcWZA2jpo+MXD54GdoNqF53c
         m19q/CaHtb1ePaIQnhyMeljztdiSGnMrX34vsRb7oT7IMWMxB0FZWEvzhePuqeGHNt
         ZfmCU7EyO5awg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 02 Feb 2023 09:58:18 -0700
Subject: [PATCH] dm flakey: Fix clang -Wparentheses-equality in
 flakey_map()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-dm-parenthesis-warning-v1-1-ebdee213eeb9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKnr22MC/x2NywqDUAxEf0WybsBXC/ZXShe5Gr1ZGCWRtiD+e
 6ObgcPMYXZwNmGHZ7GD8UdcFg2obgX0mXRilCEY6rJuyggcZlzJWLfMLo5fMhWd8FE13dime2w
 ShJzIGZOR9vnUZ/KN7SxW41F+1+PrfRx/R+eoXoEAAAA=
To:     agk@redhat.com, snitzer@kernel.org
Cc:     ndesaulniers@google.com, trix@redhat.com,
        sweettea-kernel@dorminy.me, mpatocka@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=nathan@kernel.org;
 h=from:subject:message-id; bh=KhsHJGMkk85ln+sCx+d+Nxt6KslFX/d/TmJqhuW9H0g=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMm338jMyt3ak5ZoWjp1c+GeSq9vPRens7H8jzrROD1P9
 uQ77t3cHaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiBQkM/8y6D75Usbo+qfwp
 271TURstM0onidn9TX6x/ef1UG3GkzGMDKc7vxoLrJXUeSF7yEvw4PyG5Ct+Ex7svLB+5YOr1zn
 KvDkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  ../drivers/md/dm-flakey.c:369:28: error: equality comparison with extraneous parentheses [-Werror,-Wparentheses-equality]
                          if ((fc->corrupt_bio_rw == WRITE)) {
                               ~~~~~~~~~~~~~~~~~~~^~~~~~~~
  ../drivers/md/dm-flakey.c:369:28: note: remove extraneous parentheses around the comparison to silence this warning
                          if ((fc->corrupt_bio_rw == WRITE)) {
                              ~                   ^       ~
  ../drivers/md/dm-flakey.c:369:28: note: use '=' to turn this equality comparison into an assignment
                          if ((fc->corrupt_bio_rw == WRITE)) {
                                                  ^~
                                                  =
  1 error generated.

GCC only warns when one set of parentheses are used for assignment
expressions, whereas clang additionally warns when two sets of
parentheses are used for equality comparisons. Remove the extra set of
parentheses to silence the warning as it suggests, as this is obviously
supposed to be an equality comparison.

Fixes: 0e766389cedc ("dm flakey: fix logic when corrupting a bio")
Link: https://github.com/ClangBuiltLinux/linux/issues/1798
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I do not mind this change being squashed with the offending commit, as I
noticed it was Cc'd for stable, which would minimize the chance for
breakage.
---
 drivers/md/dm-flakey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 08f9aa476d97..335684a1aeaa 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -366,7 +366,7 @@ static int flakey_map(struct dm_target *ti, struct bio *bio)
 		 * Corrupt matching writes.
 		 */
 		if (fc->corrupt_bio_byte) {
-			if ((fc->corrupt_bio_rw == WRITE)) {
+			if (fc->corrupt_bio_rw == WRITE) {
 				if (all_corrupt_bio_flags_match(bio, fc))
 					corrupt_bio_data(bio, fc);
 			}

---
base-commit: 6f30cc248507ee96c22ff4c3cbc86099ff12b7a9
change-id: 20230202-dm-parenthesis-warning-6139f4b5020b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

