Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E172886D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFHT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFHT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:28:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699DA2;
        Thu,  8 Jun 2023 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2OPOPDQNskA4BE/Gx3h1tR4IYFZdWY+xCSOk3HTM7xQ=; b=ndVCovkL3OxQIwE7DQTs8wzCCZ
        0+xAnPCsS1Vm90PjXkm3imrmH/DfIi+IZleBJYFlJ+Ga4ibnk0kNfYIcv4oospOfH2gnNKORBJNAd
        qjJBwkEOTA3Qp4lvVfrkgAuv83Ormd2RlKq6+A7OzcXk2lD5WATXgdvJz3LLaogKmMZFTE6XWGpnS
        gzJVGprSP3ImLnfpR1yVEbaL08HQbHYqMhH6ljv9VkzvaQZj18KftNwDf5mJoBTP1r5cENJ3Mcera
        rtCD7guY+rzOzYEd9ztulvyQAnrY9Vf82qotYfMkhcKiBFhfMFB9qvr26Kq5z/yUv2uWztWRG7qLH
        l0LXi24w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7LIg-00AM6g-1o;
        Thu, 08 Jun 2023 19:28:02 +0000
Date:   Thu, 8 Jun 2023 12:28:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, thunder.leizhen@huawei.com, boqun.feng@gmail.com,
        vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
        brauner@kernel.org, michael.christie@oracle.com,
        samitolvanen@google.com, glider@google.com, peterz@infradead.org,
        keescook@chromium.org, stephen.s.brennan@oracle.com,
        alan.maguire@oracle.com, pmladek@suse.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH v5 2/2] kallsyms: make kallsyms_show_value() as generic
 function
Message-ID: <ZIIrwo54fXemsGQo@bombadil.infradead.org>
References: <20230608033119.1543638-1-maninder1.s@samsung.com>
 <CGME20230608033140epcas5p1a1a04da5a0c78f888afbf54b00519f1e@epcas5p1.samsung.com>
 <20230608033119.1543638-2-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608033119.1543638-2-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 09:01:19AM +0530, Maninder Singh wrote:
> This change makes function kallsyms_show_value() as
> generic function without dependency on CONFIG_KALLSYMS.
> 
> Now module address will be displayed with lsmod and /proc/modules.
> 
> Earlier:
> =======
> / # insmod  test.ko
> / # lsmod
> test 12288 0 - Live 0x0000000000000000 (O)  // No Module Load address
> / #
> 
> With change:
> ==========
> / # insmod test.ko
> / # lsmod
> test 12288 0 - Live 0xffff800000fc0000 (O)  // Module address
> / # cat /proc/modules
> test 12288 0 - Live 0xffff800000fc0000 (O)
> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks! Pushed to modules-next.

  Luis
