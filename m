Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1206C6587
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCWKp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCWKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6BFA241
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1928C625D5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04899C433D2;
        Thu, 23 Mar 2023 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679568179;
        bh=USHm1i6jK/L0zHN3Lsg3UuWetUj4sc+KT0D3py6wpjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcMbzxGXWv85MR0HRk/pqA2hekjjS1ypKeKrmvBklseJWO7VpxW4KFveavYnXZImK
         1UO/StSJsNGvpSxdne1F7VkdxkiKDoj1CJlUx8A9naM8wRGqgo+e76k0jPx/prc2T7
         5yKTz1DOSAwfVQ+oKV7KGIXWJ2U9x+fLzekrnIUxp81ndZ3mTSNOTWnoJUyWcmGuAV
         7BqBEq7V1fJk6GlPcOgdYkMYz8s024swG+g17jLujVUtRmyGnpxFlgfY+WjvNUzK+m
         sgBuaFLW3MlmR4imuCAXyAoPKlcdaHjUsPAuK6pn3CGG+UR1DC+6CBolcOGe9Snho3
         xw8SPPsPDqyyw==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Mike Christie <michael.christie@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Date:   Thu, 23 Mar 2023 11:42:52 +0100
Message-Id: <167956804775.1616340.6808220996254153034.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322185605.1307-1-michael.christie@oracle.com>
References: <20230322185605.1307-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=468; i=brauner@kernel.org; h=from:subject:message-id; bh=XoALu1IqJYPCn7OqL9VbbUgtU244gV3N2QsPkNS+BjQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTI6Gps+bY6ZP2fiCcbr2u/q3lziatmws9Ul1kG/GU5qdEX gp8md5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk2jFGhvP2mpO0nyxRF3pgEG5Ycm rqw4e5mmrdV76nz3Q4tzzU5C/D/wqWjWJrmKac8zyefenPq9mbuP7/a5YMevrtRdfWS+eebeQFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 13:56:05 -0500, Mike Christie wrote:
> vhost_task_create is supposed to return the vhost_task or NULL on
> failure. This fixes it to return the correct value when the allocation
> of the struct fails.
> 
> 

Applied, thanks!

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
branch: kernel.user_worker

[1/1] vhost_task: Fix vhost_task_create return value
      commit: cbc0fc3d37b88182c1454da02002cd7d99b4a28e
