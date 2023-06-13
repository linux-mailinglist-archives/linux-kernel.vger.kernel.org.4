Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0A72E92B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjFMRP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFMRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:15:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86801BD3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:15:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 97cKqpd5hx5Vb97cKqvfRE; Tue, 13 Jun 2023 19:15:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686676542;
        bh=nJwk0bnAQ0Xv6sG4ivedyKkZihPzSwcBd5Y0QPp0N8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MVyQ422go+DjjzMaDCYxv4dYV00tNMyAXp4VRoC/u+vRBDxhF+r1NEVXlvPeaj/G1
         XPSj8iTmg8nxd5idXgfiqg6JZVHpk5RTaUP4LxVOK/IZwbhwMnQfAZS0jhdD4pWjC9
         cVL/de62rrH4bsDt84FJLrm8k95o8VmS/v4Pyf5unBP2Gj00S1+n5TqYCCRKY95uNM
         tWaQYID9AN+jWNhvsMRiPF2lb3RKXwTyFlDcXOPYgDmyoEVrFlieyzA+cBWyDHPGLK
         vreUmFehIue4Nx7PF08o4Fk2E4nLcvvXSN+ZT6q+qjLsM1/KfHEtR3ib8LYjRPbOil
         6q+UQea0BNfGA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Jun 2023 19:15:42 +0200
X-ME-IP: 86.243.2.178
Message-ID: <34b714b6-cb49-1a34-58f5-8b5ef0da2714@wanadoo.fr>
Date:   Tue, 13 Jun 2023 19:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] media: v4l2-core: Fix a potential resource leak in
 v4l2_fwnode_parse_link()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <2ddd10ec9e009bbb85518355f1e09e1ecd349925.1685340968.git.christophe.jaillet@wanadoo.fr>
 <ZIhLDh567eWqY5vk@kekkonen.localdomain>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZIhLDh567eWqY5vk@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/06/2023 à 12:55, Sakari Ailus a écrit :
> Hi Christophe,
> 
> On Mon, May 29, 2023 at 08:17:18AM +0200, Christophe JAILLET wrote:
>> 'fwnode is known to be NULL, at this point, so fwnode_handle_put() is a
>> no-op.
>>
>> Release the reference taken from a previous fwnode_graph_get_port_parent()
>> call instead.
>>
>> Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> /!\  THIS PATCH IS SPECULATIVE  /!\
>>           review with care
>> ---
>>   drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
>> index 049c2f2001ea..b7dd467c53fd 100644
>> --- a/drivers/media/v4l2-core/v4l2-fwnode.c
>> +++ b/drivers/media/v4l2-core/v4l2-fwnode.c
>> @@ -571,7 +571,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
>>   
>>   	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
>>   	if (!fwnode) {
>> -		fwnode_handle_put(fwnode);
>> +		fwnode_handle_put(link->local_node);
> 
> link->local_node also needs to be non-NULL for the successful case. The
> condition should take that into account. Could you send v2 with that?
> 
>>   		return -ENOLINK;
>>   	}
>>   
> 

Hi,
something like below?

@@ -568,19 +568,25 @@ int v4l2_fwnode_parse_link(struct fwnode_handle 
*fwnode,
  	link->local_id = fwep.id;
  	link->local_port = fwep.port;
  	link->local_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->local_node)
+		return -ENOLINK;

  	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
-	if (!fwnode) {
-		fwnode_handle_put(fwnode);
-		return -ENOLINK;
-	}
+	if (!fwnode)
+		goto err_put_local_node;

  	fwnode_graph_parse_endpoint(fwnode, &fwep);
  	link->remote_id = fwep.id;
  	link->remote_port = fwep.port;
  	link->remote_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->remote_node)
+		goto err_put_local_node;

  	return 0;
+
+err_put_local_node:
+	fwnode_handle_put(link->local_node);
+	return -ENOLINK;
  }
  EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);


CJ
