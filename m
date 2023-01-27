Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A796667E53F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjA0Mbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjA0Mbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DE61CAF4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F947B820FD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B66C433EF;
        Fri, 27 Jan 2023 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674822684;
        bh=aNk+4mGXrZr3Rq7i4ehTc92cGdF5tRn6YDVJ193U5v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGSm22Fis5soyioFNYUep5FfddGVQ9DVVmaoq96qXy4lmRWXRhDdOEpIazlRiwCGO
         p7JHrC3vaSLTwR/Ccel224wy3fYkaojmog8jztCKkNSTUm0Hh+K9XlkttMCbYeWTKj
         UvgTN9sIhZlF29jlrOQbhY1VKj1T2kIjs8E1jFYFvttyI94f8Ozdwgg/4NgVBzfP3w
         6c9ptDQ11nldtdZqJOMnB/pk6OIQ59yUapXa8BpnkkeP5v5Lvt0uei2tejwOgBmpW+
         ZNg1qFBGZpeKnQVWxrU3fhhOR4fd4FOzTKsowdjx5o9Ojj3FXZh1GBF1ouzFfDBfUe
         OfJWopp1t7N7Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Date:   Fri, 27 Jan 2023 13:31:13 +0100
Message-Id: <167482213665.546991.3626486119597692007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120102512.3195094-1-gscrivan@redhat.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org; h=from:subject:message-id; bh=/YnbsRyF/VAOdBsPrzLZepBNYunlAAmRfPLNuhM2ebk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfPrz4B/vLk70/XO5efFul+yi0omTizUuMAcl+Aq3fv/Ze un9gYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEnigw/HeU6Agqef5I/Hx0spCs4p NDAT9OrlZOvBjy+VrbTa/gJ4oM/4viTv01P77G1Gpr27JNjYGNJk/FbybY6NhOtlLNshZexgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Fri, 20 Jan 2023 11:25:11 +0100, Giuseppe Scrivano wrote:
> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> processes to hide their own /proc/*/exe file. When this prctl is
> used, every access to /proc/*/exe for the calling process will
> fail with ENOENT.
> 
> This is useful for preventing issues like CVE-2019-5736, where an
> attacker can gain host root access by overwriting the binary
> in OCI runtimes through file-descriptor mishandling in containers.
> 
> [...]

Only needed for privileged sandboxes. The userspace mitigations Aleksa
and I did for the CVE in all affected runtimes back then are nifty but
complicated. The patch is a decent compromise.
Picking up this prctl() for now,

[1/2] exec: add PR_HIDE_SELF_EXE prctl
      commit: 673301182d473ef61a98c292cf64650c73117172
[2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
      commit: bafa339eda3f79d567386e1fae59bb0537156c96
