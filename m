Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB2625016
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKKCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiKKCUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:20:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065C1570B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:20:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 21so5861798edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhyNiHm2oPgi1VpMkAJAvwBfBmXi+jO4fsobvj9Vl60=;
        b=Y0mibHbjN/w59P/N/dvD5tHHym9l0E0s/awsvzTneifbl1oF/yZR9Gfg2bcuB2+bid
         HrUpewy1J2qFj/corraKOcDNFngu2YckxNYCdUXw0ffabOud+q5vIDmmMOmQeH1+bKES
         RvBfGenMmGimk+Ap4hxQCq1Twn2Ftx+7G+uV2m1EThx5Z26BtETnGjcqj0lr1cZnt8ua
         iIyfQfEQaiRu8Zt/2CVs6O1LCYgKiWTchHTFQzmVhZ/sc2AcDhzq2VATlsgye6t2jU7W
         s0+ngIZtkvpR0U1mOP4BZoJIOZdDxSIiumMdH2vZVf9thyHZKPNL2c4sepXgupHDTb80
         aSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhyNiHm2oPgi1VpMkAJAvwBfBmXi+jO4fsobvj9Vl60=;
        b=79uKVR15GsicwQldjPY/ehCvmB5GTCyoOT9WSuW21/9Lp15D9IV51gEymclCI32Nw9
         lT4b3C9tg5Ykq9HLzmxSGjd4h6Lv77QAAgmyRv7JcOX9rBRLTeByf4HraP9J7Um3cIKK
         hkiEmDwRkzct5oP/Huh6K899Wv8sOt2Bc+QZmsYS1y3dZLNHZiORBY5bj+VfDZKjw47v
         JR8u7N9jpNHn1iQgpdb1xaGb99lLe8G8WW7cxYAPErAQNff8oABfTvQv5+xgf5KN/s7k
         0B+Ohu3Mnx092zXqvFSRnVsDnuKsLF4/2CE72WMtVbFDCvPb7SgTB3Yex3jxSCqPnf4t
         oKyA==
X-Gm-Message-State: ACrzQf1lFlNxif6Le9YMrgJZEZNOZNGPWI+bfSMnGU7iklrjgnPRcLhZ
        5NFTf3S+4Q4peuiZzL8b/FI=
X-Google-Smtp-Source: AMsMyM5jH/Qf7VBA2FmSWMerrhC86pwOWIQiVdST8Q0qdBQJvVFSFswa0OrILVRibx4c/JyP0Ap0Ow==
X-Received: by 2002:a05:6402:d50:b0:463:5d1b:99fb with SMTP id ec16-20020a0564020d5000b004635d1b99fbmr4317776edb.269.1668133210783;
        Thu, 10 Nov 2022 18:20:10 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b0077f20a722dfsm335318ejb.165.2022.11.10.18.20.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Nov 2022 18:20:10 -0800 (PST)
Date:   Fri, 11 Nov 2022 02:20:09 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] maple_tree: should get pivots boundary by type
Message-ID: <20221111022009.tfrap5qx5oy5vnsc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20221110072459.23656-1-richard.weiyang@gmail.com>
 <20221110161239.crapogyt7owdqd7y@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110161239.crapogyt7owdqd7y@revolver>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 04:14:31PM +0000, Liam Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [221110 02:25]:
>> If my understanding is correct, we should get pivots boundary by type.
>> 
>
>Thank you, yes - you are correct.  This is a bug, and should have:

Thanks. I am curious why this doesn't trigger a problem yet?

From code, it seems we may access the out of boundary array.

>
>Fixes: 54a611b60590 (Maple Tree: add new data structure)
>
>Please fix your commit message and add the fixes line and resend.
>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>

-- 
Wei Yang
Help you, Help me
