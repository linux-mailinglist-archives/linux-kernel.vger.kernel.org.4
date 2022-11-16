Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19662C692
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiKPRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:42:51 -0500
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8C5E3DE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=diO8MiigQr/mJnJgrMgnwnmeSV/eRZr21rlA7bzda5I=;
 b=x+d3z3D1WpdYnTVMjqi7lZgcNl5IAoIwv1j2uN+eoHQo81udc9huVL0xM0e8fNvSz8YNQHPQAOqy
   g3sOMoteMxTShdFWWbefSWf59vckKIBdAuTxNwS4s1mgQZEYqnzXepASiwFky8G9p1ZrA8lwF57y
   0iYis5PwTby/Ingbf3FirJqsPBxx4OYlPC9CIgDQshsDdcmpK9rHs7+YnWeBsbbVqWW66FQw4n8k
   QjMWq3bC93ftBZYrBMwucB6/3tmoKa4yfF7as5R18lh1q7mKf+6Qi8KtooAjVa8Y264jJVTK6R0R
   OV7It9ywjCbyuq13CRilYvpP4JVWiF3qX52ehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=diO8MiigQr/mJnJgrMgnwnmeSV/eRZr21rlA7bzda5I=;
 b=cOV7QhUrmh12sUHXJhueHW5vOReBSoopCJAYw0xdLLG6f7zHm0Nuo9EUGjUT9e0W7iq3jDUDptA9
   dBfeQSCGw5EbfRobDcGuHs12qmk7SKX7lcriFWgzNsaBpZjPoZ2iJC9+ikOUFC+AbqOQgMy8a6Cq
   PY1egSJd6LKfwEAF0hsmX+JFvRVqmyZQToD8mo8BbFO05r3DQWjRh+KiRJtNd0rNtgg6MEghSrA2
   UQ8YhwaVpFJry6QdLj/Wz/UGzKkA6kyaQk2K3PRq8bca9CrO+VBQwtiX9i6AqKa2myKzpnQKTy4c
   FUOSJdIijnzNFdn9jie2QWzaMzyms/FFVvgqmQ==
Received: by omta-ad1-fd3-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20221104 64bit (built Nov  4
 2022))
 with ESMTPS id <0RLG00IX6BVB1RB0@omta-ad1-fd3-101-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Wed, 16 Nov 2022 17:42:47 +0000 (GMT)
Message-id: <e775398c-97bc-fc1d-a785-6d3c80bce9c6@augustwikerfors.se>
Date:   Wed, 16 Nov 2022 18:42:43 +0100
MIME-version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G
 and 512G
Content-language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116171727.4083-1-git@augustwikerfors.se>
 <20221116171935.GA24524@lst.de>
From:   August Wikerfors <august@augustwikerfors.se>
In-reply-to: <20221116171935.GA24524@lst.de>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEu+0BrTkHBsWLOK63HjpEKIIURzBrIK56dK+jBm3s0DHlxjT4P2/MBeqUBNrmp
 VCVIkws4O2zsNXnjRWHBTJ823k/tfg+rw6nyTm/QnhFtUrkMI7LOoXHLCRD6dR+f
 N72Bhh+HAKyLtACNM9amqkotOc+PuzBSj8ptTPJtj6thT8CroDe6+7z4dRD8fsxk
 F5BvqoMl8hLKOKMGayvfuDyTpqSZK7/9NbsQCc4Aui5OFa9tyovzghoSYEQEb9VP
 bc9zc7mOY8jCyqx8K0+6ck/m/LUin4URhdsiMlYMFqPRKCK/rbF9UlhvjM+bTkjJ
 fUieOv9K5ltWqJldYSfikYZ/3b02G+rhkj/nohEKNLAF6pJhslWxfwtV5NyQ082Z
 2H0i+a7cYU2jTclY8sUJ1yMZTocSeSHXeRwrBE6Q06HKd843qiPKToCqlwxj+T/u U0ryQc0=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-16 18:19, Christoph Hellwig wrote:
> On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
>> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
>> reports eui as 0001000200030004 when resuming from s2idle, causing the
>> device to be removed with this error in dmesg:
>>
>> nvme nvme0: identifiers changed for nsid 1
> 
> What EUI did it report before? Is the identifier stable after
> multiple resume cycles?
The original EUI is "002538e621b440e5". Using the patches from [1] and 
[2] for debugging I consistently get this output on every resume:
> eui changed from 002538e621b440e5 to 0001000200030004
[1] https://lore.kernel.org/all/20220408025704.6352-1-me@kingtous.cn/
[2] https://lore.kernel.org/all/20220408062210.GA410@lst.de/
