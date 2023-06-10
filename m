Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E172A8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 06:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjFJEBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 00:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJEBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 00:01:03 -0400
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E566319BB;
        Fri,  9 Jun 2023 21:00:58 -0700 (PDT)
Received: from [IPV6:240e:3b7:3279:1440:9db:41ed:be98:62d0] (unknown [IPV6:240e:3b7:3279:1440:9db:41ed:be98:62d0])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 8BC2C280E48;
        Sat, 10 Jun 2023 12:00:53 +0800 (CST)
Message-ID: <6a1a873a-e2d9-dce0-8fcb-9415b6124550@sangfor.com.cn>
Date:   Sat, 10 Jun 2023 12:01:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH net-next] net: ethtool: Fix out-of-bounds copy to user
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pengdonglin@sangfor.com.cn,
        huangcun@sangfor.com.cn, jacob.e.keller@intel.com
References: <20230601112839.13799-1-dinghui@sangfor.com.cn>
 <f7e23fe6-4d30-ef1b-a431-3ef6ec6f77ba@sangfor.com.cn>
 <6e28cea9-d615-449d-9c68-aa155efc8444@lunn.ch>
 <CAKgT0UdyykQL-BidjaNpjX99FwJTxET51U29q4_CDqmABUuVbw@mail.gmail.com>
 <ece228a3-5c31-4390-b6ba-ec3f2b6c5dcb@lunn.ch>
 <CAKgT0Uf+XaKCFgBRTn-viVsKkNE7piAuDpht=efixsAV=3JdFQ@mail.gmail.com>
 <44905acd-3ac4-cfe5-5e91-d182c1959407@sangfor.com.cn>
 <20230602225519.66c2c987@kernel.org>
 <5f0f2bab-ae36-8b13-2c6d-c69c6ff4a43f@sangfor.com.cn>
 <20230604104718.4bf45faf@kernel.org>
 <f6ad6281-df30-93cf-d057-5841b8c1e2e6@sangfor.com.cn>
 <20230605113915.4258af7f@kernel.org>
 <034f5393-e519-1e8d-af76-ae29677a1bf5@sangfor.com.cn>
 <CAKgT0UdX7cc-LVFowFrY7mSZMvN0xc+w+oH16GNrduLY-AddSA@mail.gmail.com>
 <9c1fecc1-7d17-c039-6bfa-c63be6fcf013@sangfor.com.cn>
 <20230609101301.39fcb12b@kernel.org>
 <CAKgT0UeePd_+UwpGTT_v7nacf=yLoravtEZ2-gN4dpeWC5AsBg@mail.gmail.com>
 <ffa3498a-4227-837c-b7b8-e00f4b327a80@sangfor.com.cn>
In-Reply-To: <ffa3498a-4227-837c-b7b8-e00f4b327a80@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHh0eVkkZQhhPGh5DTklOQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEJBSk9PS0FCHxlBT0oeH0EZHkJDQU1JH0tZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Tid: 0a88a376d49d2eb1kusn8bc2c280e48
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46CDo4Vj1WLiMdGhwLAzIU
        ETQwCSNVSlVKTUNNSE1CTU5PSUJPVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxCQUpPT0tBQh8ZQU9KHh9BGR5CQ0FNSR9LWVdZCAFZQU9OQkk3Bg++
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/10 11:47, Ding Hui wrote:
> On 2023/6/10 1:59, Alexander Duyck wrote:
>> On Fri, Jun 9, 2023 at 10:13 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>> On Fri, 9 Jun 2023 23:25:34 +0800 Ding Hui wrote:
>>>> drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c: .get_sset_count         = nfp_net_get_sset_count,
>>>> drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c: .get_sset_count         = nfp_port_get_sset_count,
>>>
>>> Not sure if your research is accurate, NFP does not change the number
>>> of stats. The number depends on the device and the FW loaded, but those
>>> are constant during a lifetime of a netdevice.
> 
> Sorry, my research is rough indeed.
> 
>>
>> Yeah, the value doesn't need to be a constant, it just need to be constant.
>>
>> So for example in the ixgbe driver I believe we were using the upper
>> limits on the Tx and Rx queues which last I recall are stored in the
>> netdev itself.
>>
> Thanks to point that, the examples NFP and ixgbe do help me.

The commit f8ba7db85035 ("ice: Report stats for allocated queues via ethtool stats")
also helps a lot.

-- 
Thanks,
-dinghui

