Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865836A0C64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjBWPAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjBWPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:00:01 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE918B2A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:59:56 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 52DF2261815;
        Thu, 23 Feb 2023 14:59:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CE42C26109B;
        Thu, 23 Feb 2023 14:59:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677164394; a=rsa-sha256;
        cv=none;
        b=orDvW8180PN+7+UnM0a/7O3sVkpxzJ5trnDqjKm2pNTXS2WnyqaQBGMRCXKqVQGb5zdrgW
        BxKUeFE55F7KIeckieb8AEePK85fpCg1Tue2hNVPMCjAGW4lpAE8K7O8U+toFJhGHCpEiH
        d7jDWQZ4sODDZA6wXdBTknX2zLyTHxdGgzhnkFA/2bsArub03onG+E27s8vqdDBeLpsm+i
        GStff8vvIwepYtWySq/IVo0VgHTS5mroUMCRjVZf6GR+Q9NpDbGq7uIScparrfRdnAxkmT
        kXPtyto57Ji8fkXIHjgMvRYw1cdX3Sa6uiIaaqrgBIMeYeajN8iXmcJpAtVgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677164394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=h6jsx5v4PpV6vzaULv4y0p9JanPgax7mq8sgQ5FafXM=;
        b=pb1VvB7iQDfrcFU4GzoCHhEMWtDJweg5cLHFl1nARBkvGltEJktZTZhUCWOg6nTlJuO2UE
        AiNc8AbOWnDanRqX5ZrMXJvAbuNXpUnO0Aqc1ccW6MpZ0qeL17w1wwIkBEU+KJRZUtOUj/
        VQ9axtV9PbOM7r1Tvfmu6g7j5vA2EbnUJRMtLzII6pY0rymGgRBunSVTDLBqWrISsXVjex
        HJOOg65ybhwXG0ZZ2sHk9FsafAw7DJJSMy94TD7jMRogbswlN4rYAV1SF5S/JcTDFHCDDE
        lqsPvSdsFszg/drdlJPgzmfRVn03CNugIdkk2aAyvJ2/XZRJo3l2rOy9WZEsoA==
ARC-Authentication-Results: i=1;
        rspamd-5db48964c-ckdrb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Harmony: 394007ff079e8c8d_1677164395121_1943540222
X-MC-Loop-Signature: 1677164395121:855036862
X-MC-Ingress-Time: 1677164395121
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.126 (trex/6.7.1);
        Thu, 23 Feb 2023 14:59:55 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4PMx5Q1qmQz88;
        Thu, 23 Feb 2023 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677164394;
        bh=h6jsx5v4PpV6vzaULv4y0p9JanPgax7mq8sgQ5FafXM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=J8b0BaXpn5lHsCOxSt8W244UcqjYt9+Ame4imJzDQPfUfYXTSk+4kK2PHFV516Nyf
         4BIccGhOtaK/URIynRzAohJSeAp0JfZMGgXLMgHq2otMlkEuBOl+hJLVQTz830QcJk
         QGtFHkyIKGIk8ZiOc9cYqMc3osjs7VOS8hxsNMeZzEzxooztxfFxZhNVvRsYvv7lEf
         W48pB6TtwRaCCcf3Te78ZlJNkq5f4ACGTNLzPBflETNscSlQk8lA3xygoGbYed6E9S
         FS9CFzKuhhIdwKE2YG+j99nl1RbR3smr/h8dT6Nq0E5JiSyaUw3jGyZk2orwsROTXq
         pWyWb51b4Rydw==
Date:   Thu, 23 Feb 2023 06:31:30 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230223143130.yw4v3fz5pm32p7x4@offworld>
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230222225755.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230223035359.6jgserikqtc3vnra@offworld>
 <20230223043411.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58805C9797BEC218610C5145DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58805C9797BEC218610C5145DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023, Zhang, Qiang1 wrote:

>If I understand correctly, I should remove #ifdef statements, right?

Yes, but also please make torture_type default depend on PREEMPT_RT.

Thanks,
Davidlohr
