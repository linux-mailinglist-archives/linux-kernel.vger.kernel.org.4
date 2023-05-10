Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C16FE236
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjEJQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJQOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:14:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF87AB1;
        Wed, 10 May 2023 09:14:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QGg7v6gD0z67mYL;
        Thu, 11 May 2023 00:14:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 10 May
 2023 17:14:46 +0100
Date:   Wed, 10 May 2023 17:14:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
Message-ID: <20230510171445.00004cea@Huawei.com>
In-Reply-To: <168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3>
References: <168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023 14:34:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Dan Williams suggested changing the struct 'node_hmem_attrs' to
> 'access_coordinates' [1]. The struct is a container of r/w-latency and
> r/w-bandwidth numbers. Moving forward, this container will also be used by
> CXL to store the performance characteristics of each link hop in
> the PCIE/CXL topology. So, where node_hmem_attrs is just the access
> parameters of a memory-node, access_coordinates applies more broadly
> to hardware topology characteristics.

Not that it hugely matters, but why the term "coordinates"?
Looks like Dan used that term, but I've not come across it being applied
in this circumstances and it isn't a case of being immediately obvious
to me what it means.

If it is just another vague entry in kernel word soup then I don't really
mind the term, but nice to give some reasoning in patch description.

Patch otherwise looks fine to me.

Jonathan


> 
> [1]: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c |   20 ++++++++++----------
>  drivers/base/node.c      |   12 ++++++------
>  include/linux/node.h     |    8 ++++----
>  3 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index bba268ecd802..f9ff992038fa 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -62,7 +62,7 @@ struct memory_target {
>  	unsigned int memory_pxm;
>  	unsigned int processor_pxm;
>  	struct resource memregions;
> -	struct node_hmem_attrs hmem_attrs[2];
> +	struct access_coordinate coord[2];
>  	struct list_head caches;
>  	struct node_cache_attrs cache_attrs;
>  	bool registered;
> @@ -227,24 +227,24 @@ static void hmat_update_target_access(struct memory_target *target,
>  {
>  	switch (type) {
>  	case ACPI_HMAT_ACCESS_LATENCY:
> -		target->hmem_attrs[access].read_latency = value;
> -		target->hmem_attrs[access].write_latency = value;
> +		target->coord[access].read_latency = value;
> +		target->coord[access].write_latency = value;
>  		break;
>  	case ACPI_HMAT_READ_LATENCY:
> -		target->hmem_attrs[access].read_latency = value;
> +		target->coord[access].read_latency = value;
>  		break;
>  	case ACPI_HMAT_WRITE_LATENCY:
> -		target->hmem_attrs[access].write_latency = value;
> +		target->coord[access].write_latency = value;
>  		break;
>  	case ACPI_HMAT_ACCESS_BANDWIDTH:
> -		target->hmem_attrs[access].read_bandwidth = value;
> -		target->hmem_attrs[access].write_bandwidth = value;
> +		target->coord[access].read_bandwidth = value;
> +		target->coord[access].write_bandwidth = value;
>  		break;
>  	case ACPI_HMAT_READ_BANDWIDTH:
> -		target->hmem_attrs[access].read_bandwidth = value;
> +		target->coord[access].read_bandwidth = value;
>  		break;
>  	case ACPI_HMAT_WRITE_BANDWIDTH:
> -		target->hmem_attrs[access].write_bandwidth = value;
> +		target->coord[access].write_bandwidth = value;
>  		break;
>  	default:
>  		break;
> @@ -701,7 +701,7 @@ static void hmat_register_target_cache(struct memory_target *target)
>  static void hmat_register_target_perf(struct memory_target *target, int access)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
> -	node_set_perf_attrs(mem_nid, &target->hmem_attrs[access], access);
> +	node_set_perf_attrs(mem_nid, &target->coord[access], access);
>  }
>  
>  static void hmat_register_target_devices(struct memory_target *target)
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 2cada01c70da..fc0444b617d0 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -75,14 +75,14 @@ static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
>   * @dev:	Device for this memory access class
>   * @list_node:	List element in the node's access list
>   * @access:	The access class rank
> - * @hmem_attrs: Heterogeneous memory performance attributes
> + * @coord:	Heterogeneous memory performance coordinates
>   */
>  struct node_access_nodes {
>  	struct device		dev;
>  	struct list_head	list_node;
>  	unsigned int		access;
>  #ifdef CONFIG_HMEM_REPORTING
> -	struct node_hmem_attrs	hmem_attrs;
> +	struct access_coordinate	coord;
>  #endif
>  };
>  #define to_access_nodes(dev) container_of(dev, struct node_access_nodes, dev)
> @@ -168,7 +168,7 @@ static ssize_t property##_show(struct device *dev,			\
>  			   char *buf)					\
>  {									\
>  	return sysfs_emit(buf, "%u\n",					\
> -			  to_access_nodes(dev)->hmem_attrs.property);	\
> +			  to_access_nodes(dev)->coord.property);	\
>  }									\
>  static DEVICE_ATTR_RO(property)
>  
> @@ -188,10 +188,10 @@ static struct attribute *access_attrs[] = {
>  /**
>   * node_set_perf_attrs - Set the performance values for given access class
>   * @nid: Node identifier to be set
> - * @hmem_attrs: Heterogeneous memory performance attributes
> + * @coord: Heterogeneous memory performance coordinates
>   * @access: The access class the for the given attributes
>   */
> -void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> +void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			 unsigned int access)
>  {
>  	struct node_access_nodes *c;
> @@ -206,7 +206,7 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>  	if (!c)
>  		return;
>  
> -	c->hmem_attrs = *hmem_attrs;
> +	c->coord = *coord;
>  	for (i = 0; access_attrs[i] != NULL; i++) {
>  		if (sysfs_add_file_to_group(&c->dev.kobj, access_attrs[i],
>  					    "initiators")) {
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 427a5975cf40..25b66d705ee2 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -20,14 +20,14 @@
>  #include <linux/list.h>
>  
>  /**
> - * struct node_hmem_attrs - heterogeneous memory performance attributes
> + * struct access_coordinate - generic performance coordinates container
>   *
>   * @read_bandwidth:	Read bandwidth in MB/s
>   * @write_bandwidth:	Write bandwidth in MB/s
>   * @read_latency:	Read latency in nanoseconds
>   * @write_latency:	Write latency in nanoseconds
>   */
> -struct node_hmem_attrs {
> +struct access_coordinate {
>  	unsigned int read_bandwidth;
>  	unsigned int write_bandwidth;
>  	unsigned int read_latency;
> @@ -65,7 +65,7 @@ struct node_cache_attrs {
>  
>  #ifdef CONFIG_HMEM_REPORTING
>  void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
> -void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> +void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			 unsigned access);
>  #else
>  static inline void node_add_cache(unsigned int nid,
> @@ -74,7 +74,7 @@ static inline void node_add_cache(unsigned int nid,
>  }
>  
>  static inline void node_set_perf_attrs(unsigned int nid,
> -				       struct node_hmem_attrs *hmem_attrs,
> +				       struct access_coordinate *coord,
>  				       unsigned access)
>  {
>  }
> 
> 

