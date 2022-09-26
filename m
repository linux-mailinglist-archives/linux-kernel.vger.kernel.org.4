Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1C5EB2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIZUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIZUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A8AC38D;
        Mon, 26 Sep 2022 13:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 267F1612D8;
        Mon, 26 Sep 2022 20:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F8C433D6;
        Mon, 26 Sep 2022 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664225596;
        bh=a2SL8OMG8Jsrh+yHVD4uNX+IEPDu9VdFOHJpGpw2qcY=;
        h=From:To:Cc:Subject:Date:From;
        b=E0L1RlhcpeWDfO4HpbmH4kDLrN4f/tqaNdXj6QFXwj3d1/0AjUw3iauKfN+jzX6Qr
         WDEGorU+eEjj4oj5sfoonLEexowR81bRCaWRpc9ikc3g7KZEfFgsEjD5Jx2850nMA6
         b4ra3giB3uwjKx3Mv8oWT1jCH9TO8BnLSeR+ENj38tUQj/UgujRgEvltQAoD+JIkyt
         ohW7FoajFp8alkSqU1upwuMxUwRFui/ekHDBT8CidNgcErmPiLUCXbdaJyrsmt9YIg
         oZVOJmrrxvpx5tjWXpJCAW6ync2kPr9Qp7JV9L6oO7FoTRB/3cj5MkLU+MCwpRD2pq
         jWJO5z/au+Ylw==
From:   broonie@kernel.org
To:     Pavel Machek <pavel@ucw.cz>,
        Bernardo Rodrigues <bernardocrodrigues@live.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the leds tree
Date:   Mon, 26 Sep 2022 21:53:01 +0100
Message-Id: <20220926205301.614077-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the leds tree, today's linux-next build (x86 allmodconfig)
failed like this:

/tmp/next/build/drivers/leds/leds-pca963x.c: In function 'pca963x_register_leds':
/tmp/next/build/drivers/leds/leds-pca963x.c:355:3: error: this 'if' clause does not guard... [-Werror=misleading-indentation]
  355 |   if (hw_blink)
      |   ^~
/tmp/next/build/drivers/leds/leds-pca963x.c:357:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
  357 |    led->blinking = false;
      |    ^~~
cc1: all warnings being treated as errors

Caused by commit

   fd6dd9584ed3ee6deb ("leds: pca963x: fix blink with hw acceleration")

I am continuing to use the version from 20220921.
