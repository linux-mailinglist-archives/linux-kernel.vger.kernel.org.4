Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2A60BDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiJXWth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiJXWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:48:59 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4882DB7BF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:10:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C67378C2181;
        Mon, 24 Oct 2022 20:16:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0D1978C22EE;
        Mon, 24 Oct 2022 20:16:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666642601; a=rsa-sha256;
        cv=none;
        b=4I7a8bEr2vI+XSkkI9KU3OcV2gMVY0CaQpzmCkUpr+kIB/gPRyWihiBQLCM7/GsyQWsbwr
        dQEqOjeXp/WtOl34EngTdnC4itwlJLv7ZtfPzk3DVFkmSKYNtCefCMgetfzAdG94d8Y1q6
        qNTOZavCI6hs7hYhx7Qrpkjoo8KKoDf4xLhmK35kkLb6KGdYJICYQeNq7XNAFqe4VqXYlg
        qj64WXbQHuz68KW1/WBx7MzbWIQ7I5TXrjTP1oE9AMAFkz3WlPspbPPK+C+zNL5CiDBs6t
        MH5K2nYkLARhSMvDXJQ+FiQJw/RQ3gGrvw4MKo3Xg/QCe1ACQ4SvtxhOCb+UeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666642601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=E+6NG2mvlpLLJ85Th2asX21rqEhsiDSrdhbac4JqZAs=;
        b=vpCxxjsVyCHjunATIg6t6Nq5aj+QJKIj2PIjGf9C59Mc7lRcJdfhrePFLZt0jMks0GL3ED
        L700ajNbsudC7lhuZ/KTGxvWSLM+X4ghD5I4T3x6NCR4moTy3nuu0gVe3l8bHU8TNpU9fU
        TfGp70BoxTuuR8Co/rYeMHG5kF3hipSwxjiSPF+iizNulMO9JEzvYZdOMcCppEWpq+QAAX
        0Xzdb0l8HCyPAqLv0j63pug0Mq2Hanm67D6rjtWTsREZy+sHOTyrRp2GdyauERMIgZSwMA
        mnN6NodTO7qkvIDzRiHT+gZWEnicZm7ke4okyDuGG74SHXlCJHyNieqewieBLw==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-qjg4r;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Juvenile: 08f0602734b81ede_1666642601522_1040466824
X-MC-Loop-Signature: 1666642601522:267415736
X-MC-Ingress-Time: 1666642601521
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.234.250 (trex/6.7.1);
        Mon, 24 Oct 2022 20:16:41 +0000
Received: from offworld (unknown [104.36.25.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4Mx5vB0LRzz3d;
        Mon, 24 Oct 2022 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1666642600;
        bh=E+6NG2mvlpLLJ85Th2asX21rqEhsiDSrdhbac4JqZAs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KYbZkHKpdEDF1x0BlTWLzp9CTXdEWEk9M1lgjqwPTuVcXo6SE4L1p1q+2O4+8rCTv
         YDzeaGhgJywuZv8zfj7ERNVrlel523vFZYFxa0rXXdcMG8Y7zb1qEkhCjXRIWeA2h0
         SQ/dPPYZ9T2Hj/GQ+ghU773V4+Jo8xQWC6eD/gvNddH/8nfF9G+M6E+MGNIop/nFgc
         taQ0fLYK654E4pk6A0Is/hMyQYz5+/qdBrjLdTHhQYW/WLNXUxVK1LMq7aBQYC8bCY
         HCuziWKrZOs/hll0g1PRW623Jyjk2JnVZRDUkgLcuyGS9GhbD2kHe0sf2bkRwAtLAd
         +6KkjRs9+sPcw==
Date:   Mon, 24 Oct 2022 12:55:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] memory tier, sysfs: rename attribute "nodes" to
 "nodelist"
Message-ID: <20221024195504.k4j44l7rtowhpdx7@offworld>
Mail-Followup-To: Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>, Tim Chen <tim.c.chen@intel.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>
References: <20221020015122.290097-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221020015122.290097-1-ying.huang@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022, Huang Ying wrote:

>In sysfs, we use attribute name "cpumap" or "cpus" for cpu mask and
>"cpulist" or "cpus_list" for cpu list.  For example, in my system,
>
> $ cat /sys/devices/system/node/node0/cpumap
> f,ffffffff
> $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
> 0,00100004
> $ cat cat /sys/devices/system/node/node0/cpulist
> 0-35
> $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
> 2,20
>
>It looks reasonable to use "nodemap" for node mask and "nodelist" for
>node list.  So, rename the attribute to follow the naming convention.
>
>Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>Cc: Alistair Popple <apopple@nvidia.com>
>Cc: Bharata B Rao <bharata@amd.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Hesham Almatary <hesham.almatary@huawei.com>
>Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Tim Chen <tim.c.chen@intel.com>
>Cc: Wei Xu <weixugc@google.com>
>Cc: Yang Shi <shy828301@gmail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
