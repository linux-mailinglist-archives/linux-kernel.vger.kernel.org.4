Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E87768154C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjA3Plv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjA3Plq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:41:46 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117043EC5D;
        Mon, 30 Jan 2023 07:41:44 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id ml19so9368545ejb.0;
        Mon, 30 Jan 2023 07:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzK5NqKm3YGWaIvnBzWYA/xJ8EpQYLnwL3Kv6C4EQRs=;
        b=2NhmgOgCNfrlV5oxvosWIHkKBDelStCfFH29A3w2H9uC7NDZa86fFTOeHq0iyehoqo
         CMg1Gwi/WkRpISxgrnpjfruNyJ63ZSEG1nRTlX2O24h6uVID8dQxw5T7CKkl1fNWGJTQ
         /xFb3CKrpbhv5lv+4+PATvyTb+gCzM0SOkd/ufGo60f0j+jBUeHa8/B5N3O+MDCS3U5f
         HsU9DtDveWB7/EMdzUxtYFppXcXFch6E1zKPGSqtYbjfeNMf6DL0sIFke4zdEQd97Zbc
         XtMcWpF/rZsOTcaIrCPfEG9X/cDNkWCrp+Yq7qHOgkR5QmzUIfm8JIDThi0SUOuSVt6R
         pBzA==
X-Gm-Message-State: AFqh2kofreNqZtvblVBOp8Y+R8b3YTHQeDpAqrpCDeMLV1EKSjNWcxW4
        l5/M6oiiUj/hFB6+pc7pYbX1/ttApmNo7KnG/Z4=
X-Google-Smtp-Source: AMrXdXup4ZFmnsvF3CqvSnQBC+tvG7tCgOvxCSkysOzOqqw5ESl0oBKd/akdoyYq1hiGG5Y5yBkkDQtXgKpqxNnaMCw=
X-Received: by 2002:a17:906:60c8:b0:877:612e:517e with SMTP id
 f8-20020a17090660c800b00877612e517emr6882689ejk.152.1675093302603; Mon, 30
 Jan 2023 07:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20230118063504.58026-1-xueshuai@linux.alibaba.com>
 <SJ1PR11MB60831C602B33D51DC6E604E6FCC79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <202e4635-5233-9588-6c5e-ac61d280a431@linux.alibaba.com>
In-Reply-To: <202e4635-5233-9588-6c5e-ac61d280a431@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 16:41:31 +0100
Message-ID: <CAJZ5v0hJ=XVVyw-feraYmTkGKeis7wrxDehtHOYuRSPUzYrSHA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Limit error type to 32-bit width
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 3:10 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
>
>
> On 2023/1/19 AM12:37, Luck, Tony wrote:
> >> The bit map of error types to inject is 32-bit width[1]. Add parameter
> >> check to reflect the fact.
> >>
> >> [1] ACPI Specification 6.4, Section 18.6.4. Error Types
> >>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >
> > Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.3 material, thanks!
