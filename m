Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F1699E66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBPU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBPU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:56:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4EF4CCBA;
        Thu, 16 Feb 2023 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676580996; x=1708116996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=trh0gCNOftl3aVYcciw8J95vLKFPLM/6m4zkPvUDTS0=;
  b=i5aGX+hckfWvjIlj9vnzGSBNGhZiWKKgnrCEWlb2dB/K7HflN4qqHgXO
   iA9AcEZmM+xjS9ulNjPisbuyu7RGiUNcB1JinVrGYcFpLaUbr8Sn5Nhra
   9pKE3IRuxJWSp0RsBrViokWfgS85kLgVhml6Xl0uXtXXzKkp9JXrZB2Ir
   TIMYq1zPIpI905p9+aVTSQ/cjj5jTSaGnwCYBhmikJHupZPnZ64OeJk09
   xZUtdhyb1e4n23MeYZsBgbGpRcV3VLiHWNMX0ZczSae0nZ/FNooFI5dUc
   opwuv6kJ7PYFHRyyFV8Z3bk+atuAlPoRg8W/ZMzlj+UGdEPzdeHv+cPkU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359278886"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="359278886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 12:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="620151242"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="620151242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Feb 2023 12:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CCCD1A6; Thu, 16 Feb 2023 22:57:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: [PATCH v1 1/1] device property: Clarify description on returned value in some functions
Date:   Thu, 16 Feb 2023 22:57:08 +0200
Message-Id: <20230216205708.13453-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the functions do not provide a Return: section on absence of which
kernel-doc complains. Besides that several functions return the fwnode
handle with bumped reference count. Add a respective note to make sure
that the caller drops it when it's not needed anymore.

While at it, unify the style of the Return: sections.

Reported-by: Daniel Kaehn <kaehndan@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 117 ++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 35 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..b75e63984702 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -37,6 +37,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
  * @propname: Name of the property
  *
  * Check if property @propname is present in the device firmware description.
+ *
+ * Return: true if property @propname is present. Otherwise, returns false.
  */
 bool device_property_present(struct device *dev, const char *propname)
 {
@@ -48,6 +50,8 @@ EXPORT_SYMBOL_GPL(device_property_present);
  * fwnode_property_present - check if a property of a firmware node is present
  * @fwnode: Firmware node whose property to check
  * @propname: Name of the property
+ *
+ * Return: true if property @propname is present. Otherwise, returns false.
  */
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname)
@@ -511,7 +515,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
  * Caller is responsible to call fwnode_handle_put() on the returned
  * args->fwnode pointer.
  *
- * Returns: %0 on success
+ * Return: %0 on success
  *	    %-ENOENT when the index is out of bounds, the index has an empty
  *		     reference or the property was not found
  *	    %-EINVAL on parse error
@@ -547,8 +551,10 @@ EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
  *
  * @index can be used when the named reference holds a table of references.
  *
- * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
- * call fwnode_handle_put() on the returned fwnode pointer.
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: a pointer to the reference fwnode, or an error pointer.
  */
 struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
@@ -567,7 +573,7 @@ EXPORT_SYMBOL_GPL(fwnode_find_reference);
  * fwnode_get_name - Return the name of a node
  * @fwnode: The firmware node
  *
- * Returns a pointer to the node name.
+ * Return: a pointer to the node name, or %NULL.
  */
 const char *fwnode_get_name(const struct fwnode_handle *fwnode)
 {
@@ -579,7 +585,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_name);
  * fwnode_get_name_prefix - Return the prefix of node for printing purposes
  * @fwnode: The firmware node
  *
- * Returns the prefix of a node, intended to be printed right before the node.
+ * Return: the prefix of a node, intended to be printed right before the node.
  * The prefix works also as a separator between the nodes.
  */
 const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
@@ -591,7 +597,10 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
- * Return parent firmware node of the given node if possible or %NULL if no
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: parent firmware node of the given node if possible or %NULL if no
  * parent was available.
  */
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode)
@@ -608,8 +617,11 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
  * on the passed node, making it suitable for iterating through a
  * node's parents.
  *
- * Returns a node pointer with refcount incremented, use
- * fwnode_handle_put() on it when done.
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: parent firmware node of the given node if possible or %NULL if no
+ * parent was available.
  */
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 {
@@ -629,8 +641,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  * firmware node that has a corresponding struct device and returns that struct
  * device.
  *
- * The caller of this function is expected to call put_device() on the returned
- * device when they are done.
+ * Caller is responsible to call put_device() on the returned device pointer.
  */
 struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 {
@@ -651,7 +662,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
  * fwnode_count_parents - Return the number of parents a node has
  * @fwnode: The node the parents of which are to be counted
  *
- * Returns the number of parents a node has.
+ * Return: the number of parents a node has.
  */
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
 {
@@ -670,12 +681,12 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
  * @fwnode: The node the parent of which is requested
  * @depth: Distance of the parent from the node
  *
- * Returns the nth parent of a node. If there is no parent at the requested
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: the nth parent of a node. If there is no parent at the requested
  * @depth, %NULL is returned. If @depth is 0, the functionality is equivalent to
  * fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent() and so on.
- *
- * The caller is responsible for calling fwnode_handle_put() for the returned
- * node.
  */
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 					    unsigned int depth)
@@ -700,7 +711,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
  *
  * A node is considered an ancestor of itself too.
  *
- * Returns true if @ancestor is an ancestor of @child. Otherwise, returns false.
+ * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
  */
 bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
 {
@@ -725,6 +736,9 @@ bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
@@ -735,10 +749,12 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
- * fwnode_get_next_available_child_node - Return the next
- * available child node handle for a node
+ * fwnode_get_next_available_child_node - Return the next available child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
@@ -762,7 +778,10 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 /**
  * device_get_next_child_node - Return the next child node handle for a device
  * @dev: Device to find the next child node for.
- * @child: Handle to one of the device's child nodes or a null handle.
+ * @child: Handle to one of the device's child nodes or a %NULL handle.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child)
@@ -787,6 +806,9 @@ EXPORT_SYMBOL_GPL(device_get_next_child_node);
  * fwnode_get_named_child_node - Return first matching named child node handle
  * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
@@ -800,6 +822,9 @@ EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
  * device_get_named_child_node - Return first matching named child node handle
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 						  const char *childname)
@@ -812,7 +837,10 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  * fwnode_handle_get - Obtain a reference to a device node
  * @fwnode: Pointer to the device node to obtain the reference to.
  *
- * Returns the fwnode handle.
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: the fwnode handle.
  */
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
 {
@@ -827,9 +855,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
  * fwnode_handle_put - Drop reference to a device node
  * @fwnode: Pointer to the device node to drop the reference to.
  *
- * This has to be used when terminating device_for_each_child_node() iteration
- * with break or return to prevent stale device node references from being left
- * behind.
+ * Among other cases this has to be used when terminating device_for_each_child_node()
+ * iteration with break or return to prevent stale device node references from
+ * being left behind.
  */
 void fwnode_handle_put(struct fwnode_handle *fwnode)
 {
@@ -841,6 +869,8 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
  *
+ * Return: true if device is available for use. Otherwise, returns false.
+ *
  * For fwnode node types that don't implement the .device_is_available()
  * operation, this function returns true.
  */
@@ -859,6 +889,8 @@ EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 /**
  * device_get_child_node_count - return the number of child nodes for device
  * @dev: Device to cound the child nodes for
+ *
+ * Return: the number of child nodes for a given device.
  */
 unsigned int device_get_child_node_count(const struct device *dev)
 {
@@ -934,7 +966,7 @@ EXPORT_SYMBOL_GPL(device_get_phy_mode);
  * @fwnode:	Pointer to the firmware node
  * @index:	Index of the IO range
  *
- * Returns a pointer to the mapped memory.
+ * Return: a pointer to the mapped memory.
  */
 void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
 {
@@ -947,8 +979,8 @@ EXPORT_SYMBOL(fwnode_iomap);
  * @fwnode:	Pointer to the firmware node
  * @index:	Zero-based index of the IRQ
  *
- * Returns Linux IRQ number on success. Other values are determined
- * accordingly to acpi_/of_ irq_get() operation.
+ * Return: Linux IRQ number on success. Other values are determined
+ * according to acpi_irq_get() or of_irq_get() operation.
  */
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 {
@@ -967,8 +999,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
  * number of the IRQ resource corresponding to the index of the matched
  * string.
  *
- * Return:
- * Linux IRQ number on success, or negative errno otherwise.
+ * Return: Linux IRQ number on success, or negative errno otherwise.
  */
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
 {
@@ -990,7 +1021,10 @@ EXPORT_SYMBOL(fwnode_irq_get_byname);
  * @fwnode: Pointer to the parent firmware node
  * @prev: Previous endpoint node or %NULL to get the first
  *
- * Returns an endpoint firmware node pointer or %NULL if no more endpoints
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: an endpoint firmware node pointer or %NULL if no more endpoints
  * are available.
  */
 struct fwnode_handle *
@@ -1030,6 +1064,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
  * fwnode_graph_get_port_parent - Return the device fwnode of a port endpoint
  * @endpoint: Endpoint firmware node of the port
  *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
  * Return: the firmware node of the device the @endpoint belongs to.
  */
 struct fwnode_handle *
@@ -1051,6 +1088,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_port_parent);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote device the @fwnode points to.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_port_parent(const struct fwnode_handle *fwnode)
@@ -1071,6 +1111,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port_parent);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote port the @fwnode points to.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_port(const struct fwnode_handle *fwnode)
@@ -1084,6 +1127,9 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_remote_port);
  * @fwnode: Endpoint firmware node pointing to the remote endpoint
  *
  * Extracts firmware node of a remote endpoint the @fwnode points to.
+ *
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
  */
 struct fwnode_handle *
 fwnode_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
@@ -1111,8 +1157,11 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  * @endpoint: identifier of the endpoint node under the port node
  * @flags: fwnode lookup flags
  *
- * Return the fwnode handle of the local endpoint corresponding the port and
- * endpoint IDs or NULL if not found.
+ * Caller is responsible to call fwnode_handle_put() on the returned fwnode
+ * pointer.
+ *
+ * Return: the fwnode handle of the local endpoint corresponding the port and
+ * endpoint IDs or %NULL if not found.
  *
  * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
  * has not been found, look for the closest endpoint ID greater than the
@@ -1120,9 +1169,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  *
  * Does not return endpoints that belong to disabled devices or endpoints that
  * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
- *
- * The returned endpoint needs to be released by calling fwnode_handle_put() on
- * it when it is not needed any more.
  */
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
@@ -1328,7 +1374,8 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
  * @fwnode and other device nodes. @match will be used to convert the
  * connection description to data the caller is expecting to be returned
  * through the @matches array.
- * If @matches is NULL @matches_len is ignored and the total number of resolved
+ *
+ * If @matches is %NULL @matches_len is ignored and the total number of resolved
  * matches is returned.
  *
  * Return: Number of matches resolved, or negative errno.
-- 
2.39.1

