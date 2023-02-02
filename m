Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFE6884AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBBQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBBQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:41:10 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 08:40:59 PST
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BB6F706;
        Thu,  2 Feb 2023 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1675355045; bh=9NhDOhTQXzsgk1uDWULXFvElxkaDAJYZ7M/FWrpD1RM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AOmMHc+O9mKBwwSYEFk7NH8J0DPhxFDwbciaYunLqeHSV3GqFXEE1kYWXCa2RDZVJ
         oC6i+h7Hq03MOBzX1BcqiQqsixfjJjoBMzKgwBhMjJOVi+guXIYSA1KEQTgGOfirAO
         2NuCP14XS75RxALlUYMPYP6trBmpVHNgdcvk+7IbTrL5+ihyXbU9cvSrZS07Q/aUd2
         4huc3lYju0e8nTPflZySERVoEM3Vy53IqFGyV9thaYoZ0REx6VMAmbCWi+uv2efEEm
         E4xwQOZld8HxxCLyKNihA1bq0bSz7cRMmu/9wU4vOXelGy75fA40UqZ5qR75352r1a
         55N2DRlqX0lAQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 194EA40500A;
        Thu,  2 Feb 2023 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1675355045; bh=9NhDOhTQXzsgk1uDWULXFvElxkaDAJYZ7M/FWrpD1RM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AOmMHc+O9mKBwwSYEFk7NH8J0DPhxFDwbciaYunLqeHSV3GqFXEE1kYWXCa2RDZVJ
         oC6i+h7Hq03MOBzX1BcqiQqsixfjJjoBMzKgwBhMjJOVi+guXIYSA1KEQTgGOfirAO
         2NuCP14XS75RxALlUYMPYP6trBmpVHNgdcvk+7IbTrL5+ihyXbU9cvSrZS07Q/aUd2
         4huc3lYju0e8nTPflZySERVoEM3Vy53IqFGyV9thaYoZ0REx6VMAmbCWi+uv2efEEm
         E4xwQOZld8HxxCLyKNihA1bq0bSz7cRMmu/9wU4vOXelGy75fA40UqZ5qR75352r1a
         55N2DRlqX0lAQ==
Message-ID: <cd7c50e6-9f0e-9c9b-fca3-52c2fc2514dd@mleia.com>
Date:   Thu, 2 Feb 2023 18:24:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 10/13] USB: gadget: lpc32xx_udc: fix memory leak with
 using debugfs_lookup()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
 <20230202153235.2412790-10-gregkh@linuxfoundation.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20230202153235.2412790-10-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20230202_162405_142342_7455CB99 
X-CRM114-Status: UNSURE (   8.35  )
X-CRM114-Notice: Please train this message. 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 17:32, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Jakob Koschel <jakobkoschel@gmail.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
